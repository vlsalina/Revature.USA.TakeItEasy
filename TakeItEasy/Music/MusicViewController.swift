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
    //button view
    @IBOutlet weak var musicCollectionView: UICollectionView!
    
    @IBOutlet var holder:UIView!
    
    public var position:Int = 0
    
    public var playlistIDVar = "10436707122"
    //playbackbuttons
    let playPauseButton = UIButton()
    
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    //allows audio
    var player:AVPlayer?
    var playerItem:AVPlayerItem?
    var songIsPlaying:Bool = false
    
    
    // progressbar
    @IBOutlet weak var timeSlider: UISlider!
    @IBOutlet var startTime:UILabel!
    @IBOutlet var resultTime:UILabel!
    
    // searchBar variables
    @IBOutlet weak var musicSB: UISearchBar!
    var filter : Bool = false
    var filteredSongs = Playlist()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        musicSB.delegate = self
        getMusicData(playlistID: playlistIDVar)
        drawButtons()
        configureNavbar()
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty{
            filteredSongs.songTitles = playlist.songTitles
            filteredSongs.artistNames = playlist.artistNames
            filteredSongs.albumTitles = playlist.albumTitles
            filteredSongs.coverURLs = playlist.coverURLs
            filteredSongs.mp3URLs = playlist.mp3URLs
            filter = false
        } else {
            print("resetData")
            filteredSongs.resetData()
            print(playlist.songTitles)
            for i in 0..<playlist.songTitles.count{
                if playlist.songTitles[i].lowercased().contains(searchText.lowercased()){
                    filteredSongs.songTitles.append(playlist.songTitles[i])
                    filteredSongs.artistNames.append(playlist.artistNames[i])
                    filteredSongs.albumTitles.append(playlist.albumTitles[i])
                    filteredSongs.coverURLs.append(playlist.coverURLs[i])
                    filteredSongs.mp3URLs.append(playlist.mp3URLs[i])
                }
            }
            filter = true
            
        }
        print("reload data")
        musicCollectionView.reloadData()
//        if(searchText != "\n"){
//            filter = true
//        } else{
//            filter = false
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if filter{
            return filteredSongs.songTitles.count
        }else{
            return playlist.songTitles.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        var sTitles = playlist.songTitles[indexPath.row]
        if !filteredSongs.songTitles.isEmpty{
            sTitles = filteredSongs.songTitles[indexPath.row]
        }
        var aNames = playlist.artistNames[indexPath.row]
        if(!filteredSongs.artistNames.isEmpty){
            aNames = filteredSongs.artistNames[indexPath.row]
        }
        
        position = indexPath.row
        songNameLabel!.text = sTitles
        artistNameLabel!.text = aNames
        if(songIsPlaying){
            player?.pause()
            playPauseButton.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
            songIsPlaying = false
        }
        timer?.invalidate()
        timeSlider.setValue(0, animated: true)
        startTime.text = "00:00"
        configure()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "musicCell", for: indexPath) as! MusicCollectionViewCell
        cell.layer.cornerRadius = 3
        if(filter){
            musicLoadURLImage(urlString: self.filteredSongs.coverURLs[indexPath.row], musicCell: cell)
        } else{
            musicLoadURLImage(urlString: self.playlist.coverURLs[indexPath.row], musicCell: cell)
        }
        
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
                        self.playlist.songTitles.append(song.title!)
                        self.playlist.albumTitles.append(song.album!.title!)
                        self.playlist.artistNames.append(song.artist!.name!)
                        self.playlist.mp3URLs.append(song.preview!)
                        self.playlist.coverURLs.append(song.album!.cover_medium!)
                        
                    }
                    self.configure()
                    //update initial ui elements
                    DispatchQueue.main.async {
                        self.songNameLabel!.text = self.playlist.songTitles[0]
                        self.artistNameLabel!.text = self.playlist.artistNames[0]
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
        if(filter){
            let url = URL(string: self.filteredSongs.mp3URLs[position])
            playerItem = AVPlayerItem(url:url!)
            player = AVPlayer(playerItem:playerItem!)
            let playerLayer = AVPlayerLayer(player:player!)
            playerLayer.frame = CGRect(x: 0, y: 0, width: 10, height: 50)
            self.view.layer.addSublayer(playerLayer)

        } else{
            let url = URL(string: self.playlist.mp3URLs[position])
            playerItem = AVPlayerItem(url:url!)
            player = AVPlayer(playerItem:playerItem!)
            let playerLayer = AVPlayerLayer(player:player!)
            playerLayer.frame = CGRect(x: 0, y: 0, width: 10, height: 50)
            self.view.layer.addSublayer(playerLayer)
        }
        resultTime.text = formatTimeFor(seconds: CMTimeGetSeconds((self.player?.currentItem?.asset.duration)!))

        
        // Timer
        //        let duration = player?.currentItem?.duration //{
        //            print(duration)
        //            let seconds = CMTimeGetSeconds(duration)
        //            let secondsText = Float64(seconds).truncatingRemainder(dividingBy: 60)
        //            let minutesText = Float64(seconds) / 60
        //            resultTime.text = "\(minutesText):\(secondsText)"
        //        }
        //        print("DURATION: ", duration)
        
        
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
                timer?.invalidate()
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
                //add slider functionality
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
        print(currentTime)
        timeSlider.setValue(currentTime, animated: true)
        if currentTime >= 1 {
            timer?.invalidate()
            timeSlider.setValue(0, animated: true)
            startTime.text = "00:00"
            player?.seek(to: .zero)
            
        }
    
    }
}




