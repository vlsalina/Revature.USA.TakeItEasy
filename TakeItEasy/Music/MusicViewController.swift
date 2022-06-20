//
//  MusicViewController.swift
//  TakeItEasy
//
//  Created by Matt Caulder on 6/9/22.
//

import UIKit
import AVFoundation
class MusicViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UISearchBarDelegate {
    
    // timer
    var timer : Timer?
    
    //declare variables
    var playlist = Playlist()
    var songs = [Song]()
    var songsConstant = [Song]()
    //button view
    @IBOutlet weak var musicCollectionView: UICollectionView!
    
    @IBOutlet var holder:UIView!
    
    public var position:Int = 0
    
    public var playlistIDVar = "10436707122"
    //playbackbuttons
    let playPauseButton = UIButton()
    let searchController = UISearchController()
    
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    //allows audio
    var player:AVPlayer?
    var playerItem:AVPlayerItem?
    var songIsPlaying:Bool = false
    var initialLabel:Bool = false
    
    // progressbar
    @IBOutlet weak var timeSlider: UISlider!
    @IBOutlet var startTime:UILabel!
    @IBOutlet var resultTime:UILabel!
    
    // searchBar variables
    var filter : Bool = false
    var filteredSongs = Playlist()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        
        getMusicData(playlistID: playlistIDVar)
        drawButtons()
        configureNavbar()
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredSongs.songTitles = []
        
        if searchText == ""{
            filteredSongs = playlist
        }
        for i in playlist.songTitles{
            if i.lowercased().contains(searchText.lowercased()){
                filteredSongs.songTitles.append(i)
            }
        }
        musicCollectionView.reloadData()
        if(searchText != "\n"){
            filter = true
        } else{
            filter = false
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //        if !filteredSongs.songTitles.isEmpty{
        //            return filteredSongs.songTitles.count
        //        } else {
        //            return filter ? 0 : playlist.songTitles.count
        //        }
        return songs.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        //        var sTitles = playlist.songTitles[indexPath.row]
        //        if !filteredSongs.songTitles.isEmpty{
        //            sTitles = filteredSongs.songTitles[indexPath.row]
        //        }
        //
        //
        //        position = indexPath.row
        //        songNameLabel!.text = sTitles
        //        artistNameLabel!.text = playlist.artistNames[indexPath.row]
        songNameLabel.text = songs[indexPath.row].songTitle
        artistNameLabel.text = songs[indexPath.row].artist
        
        if(songIsPlaying){
            player?.pause()
            playPauseButton.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
            songIsPlaying = false
        }
        
        configure()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "musicCell", for: indexPath) as! MusicCollectionViewCell
        cell.layer.cornerRadius = 3
        //        musicLoadURLImage(urlString: self.playlist.coverURLs[indexPath.row], musicCell: cell)
        musicLoadURLImage(urlString: songs[indexPath.row].coverURL, musicCell: cell)
        return cell
    }
    
    func configureNavbar() {
        let userid = userDefaults.string(forKey: "currentUserName")
        self.navigationItem.title = userid
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log Out", style: .done, target: self, action: #selector(logoutAction))
    }
    
    @objc func logoutAction() {
        userLoggedOut()
        dismiss(animated: true)
    }
    
    
    func getMusicData(playlistID : String){
        let urlRequest = URL(string: "https://api.deezer.com/playlist/" + playlistID + "/tracks")
        if urlRequest == nil{
            print("url does not exist")
            return
        }
        print("url exists")
        let dataTask = URLSession.shared.dataTask(with: urlRequest!, completionHandler: { data, response, error in
            print("dataTask")
            if error == nil && data != nil{
                let decoder = JSONDecoder()
                do{
                    print("decoding")
                    let musicData = try decoder.decode(Tracks.self, from: data!)
                    for song in musicData.data!{
                        print(song.preview!)
                        //                        self.playlist.songTitles.append(song.title!)
                        //                        self.playlist.albumTitles.append(song.album!.title!)
                        //                        self.playlist.artistNames.append(song.artist!.name!)
                        //                        self.playlist.mp3URLs.append(song.preview!)
                        //                        self.playlist.coverURLs.append(song.album!.cover_medium!)
                        self.songs.append(Song(songTitle: song.title!, album: song.album!.title!, artist: song.artist!.name!, mp3URL: song.preview!, coverURL: song.album!.cover_medium!))
                        self.songsConstant.append(Song(songTitle: song.title!, album: song.album!.title!, artist: song.artist!.name!, mp3URL: song.preview!, coverURL: song.album!.cover_medium!))
                    }
                    self.configure()
                    DispatchQueue.main.async {
                        self.musicCollectionView.reloadData() //reload collections or table views inside DispatchQueue.main.async
                    }
                }
                catch{
                    print("error")
                }
            }
            print("finished dataTask")
            
        })
        dataTask.resume()
        
    }
    func configure(){
        //        let url = URL(string: self.playlist.mp3URLs[position])
        let url = URL(string: songs[position].mp3URL)
        playerItem = AVPlayerItem(url:url!)
        player = AVPlayer(playerItem:playerItem!)
        let playerLayer = AVPlayerLayer(player:player!)
        playerLayer.frame = CGRect(x: 0, y: 0, width: 10, height: 50)
        self.view.layer.addSublayer(playerLayer)
        
        
        resultTime.text = formatTimeFor(seconds: CMTimeGetSeconds((self.player?.currentItem?.asset.duration)!))
        
        if(!self.initialLabel){
            //            self.songNameLabel!.text = self.playlist.songTitles[0]
            //            self.artistNameLabel!.text = self.playlist.artistNames[0]
            self.songNameLabel!.text = songs[0].songTitle
            self.artistNameLabel!.text = songs[0].artist
            
            self.initialLabel = true
        }
        
        
    }
    //Draws buttons in my Holder View
    func drawButtons(){
        //set button position
        let size:CGFloat = 50
        playPauseButton.frame = CGRect(x: (holder.frame.size.width - size)/2.0, y: 300, width: size, height: size)
        
        
        // set button image
        playPauseButton.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
        
        //set button color
        playPauseButton.tintColor = UIColor(named:"logo")
        
        //set button
        holder.addSubview(playPauseButton)
        
        // calls button functionality
        playPauseButton.addTarget(self, action: #selector(didPressPlayPauseButton), for: .touchUpInside)
        timeSlider.addTarget(self, action: #selector(sliderDidSlide), for: .valueChanged)
        
    }
    
    //play pause functionaility
    @objc func didPressPlayPauseButton(){
        if(playlist.songTitles.count > 0){
            if (player?.rate == 0 && !songIsPlaying){
                player!.play()
                print("GET SECONDS: ", CMTimeGetSeconds((self.player?.currentItem?.asset.duration)!))
                songIsPlaying = true
                playPauseButton.setBackgroundImage(UIImage(systemName:"pause.fill"), for: .normal)
                
                timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
                
            } else if (songIsPlaying){
                player!.pause()
                songIsPlaying = false
                playPauseButton.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
            }
        }
    }
    @objc func sliderDidSlide(){
        print(timeSlider.value)
        
        if let duration = player?.currentItem?.duration{
            let totalSeconds = CMTimeGetSeconds(duration)
            let value = Float64(timeSlider.value) * totalSeconds
            let seekTime = CMTime(value: Int64(value), timescale: 1)
            player?.seek(to: seekTime, completionHandler: {(completedSeek) in
                
            })
        }
    }
    // if view closes music will stop too
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let player = player{
            player.pause()
        }
    }
    func musicLoadURLImage(urlString: String, musicCell : MusicCollectionViewCell){
        //if json data didn't contain url thumbnail data, don't load image
        let urlRequest = URL(string: urlString)
        if urlRequest == nil{
            print("url does not exist")
            return
        }
        print("url exists")
        //start datatask
        let dataTask = URLSession.shared.dataTask(with: urlRequest!, completionHandler: { data, response, error in
            if error == nil && data != nil{
                DispatchQueue.main.async {
                    musicCell.albumImage.image = UIImage(data: data!)
                }
            }
            else{
                print("error loading web image")
            }
        })
        dataTask.resume()
    }
}


extension MusicViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 355, height: 355)
    }
    
}

extension MusicViewController {
    @objc func updateTime() {
        //        status.text = audioPlayer?.currentTime.description
        //        progress.progress = Float(audioPlayer!.currentTime) / Float(audioPlayer!.duration)
        //        print(CMTimeGetSeconds((player?.currentTime())!))
        startTime.text = formatTimeFor(seconds: CMTimeGetSeconds((player?.currentTime())!))
        
        // set slider
        var currentTime = Float(CMTimeGetSeconds((player?.currentTime())!)) / Float(CMTimeGetSeconds((self.player?.currentItem?.asset.duration)!))
        
        timeSlider.setValue(currentTime, animated: true)
        
        
    }
}

extension MusicViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        
        if (!text.isEmpty) {
            songs = songs.filter { x in
                if x.songTitle.lowercased().starts(with: text.lowercased()) {
                    return true
                } else {
                    return false
                }
            }
        } else {
            songs = songsConstant
        }
        musicCollectionView.reloadData()
    }
}
