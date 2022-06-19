//
//  MusicViewController.swift
//  TakeItEasy
//
//  Created by Matt Caulder on 6/9/22.
//

import UIKit
import AVFoundation
class MusicViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UISearchBarDelegate {
    
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
    var initialLabel:Bool = false
    
    // progressbar
    @IBOutlet weak var timeSlider: UISlider!
    @IBOutlet var startTime:UILabel!
    @IBOutlet var resultTime:UILabel!
    
    // searchBar variables
    @IBOutlet weak var musicSB: UISearchBar!
    var allSongs = Playlist()
    var filteredSongs = Playlist()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMusicData(playlistID: playlistIDVar)
        drawButtons()
        configureNavbar()
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return playlist.songTitles.count
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        position = indexPath.row
        songNameLabel!.text = playlist.songTitles[indexPath.row]
        artistNameLabel!.text = playlist.artistNames[indexPath.row]
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
        musicLoadURLImage(urlString: self.playlist.coverURLs[indexPath.row], musicCell: cell)
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
        let url = URL(string: self.playlist.mp3URLs[position])
        playerItem = AVPlayerItem(url:url!)
        player = AVPlayer(playerItem:playerItem!)
        let playerLayer = AVPlayerLayer(player:player!)
        playerLayer.frame = CGRect(x: 0, y: 0, width: 10, height: 50)
        self.view.layer.addSublayer(playerLayer)
        
        if(!initialLabel){
            songNameLabel!.text = playlist.songTitles[0]
            artistNameLabel!.text = playlist.artistNames[0]
            initialLabel = true
        }
        if let duration = player?.currentItem?.duration{
        let seconds = CMTimeGetSeconds(duration)
            print(seconds)
            let secondsText = seconds.truncatingRemainder(dividingBy: 60)
            resultTime.text = "00:\(secondsText)"
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
      
    }
    
    //play pause functionaility
    @objc func didPressPlayPauseButton(){
        if(playlist.songTitles.count > 0){
            if (player?.rate == 0 && !songIsPlaying){
                player!.play()
                songIsPlaying = true
                playPauseButton.setBackgroundImage(UIImage(systemName:"pause.fill"), for: .normal)
            } else if (songIsPlaying){
                player!.pause()
                songIsPlaying = false
                playPauseButton.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
            }
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



