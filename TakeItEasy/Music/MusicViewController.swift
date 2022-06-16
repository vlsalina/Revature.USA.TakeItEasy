//
//  MusicViewController.swift
//  TakeItEasy
//
//  Created by Matt Caulder on 6/9/22.
//

import UIKit
import AVFoundation
class MusicViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    //declare variables
    var playlist = Playlist()
    //button view
    @IBOutlet weak var musicCollectionView: UICollectionView!
    
    @IBOutlet var holder:UIView!
    
    public var position:Int = 0
    //timers
    public var myTime: Int = 0
    public var timer = Timer()
    
    public var mp3Url:String = ""
    public var playlistIDVar = "10436707122"
    //playbackbuttons
    let playPauseButton = UIButton()
//    let backButton = UIButton()
//    let forwardButton = UIButton()
    
    //allows audio
    var player:AVPlayer?
    var playerItem:AVPlayerItem?
    var songIsPlaying:Bool = false
    
    // progressbar
    @IBOutlet var progressBar: UIProgressView!
    @IBOutlet var startTime:UILabel!
    @IBOutlet var resultTime:UILabel!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return playlist.songTitles.count
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        mp3Url = playlist.mp3URLs[indexPath.row]
        print(mp3Url)
        position = indexPath.row
        if(songIsPlaying){
            player?.pause()
            playPauseButton.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
            songIsPlaying = false
        }
        configure()
               
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "musicCell", for: indexPath) as! MusicCollectionViewCell
        cell.backgroundColor = UIColor(named:"logo")
        cell.layer.cornerRadius = 3
        //cell.albumImage.image = UIImage(named:"1")
        //cell.layer.masksToBounds = true
        musicLoadURLImage(urlString: self.playlist.coverURLs[indexPath.row], musicCell: cell)
        
        return cell
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        getMusicData(playlistID: playlistIDVar)
        drawButtons()
        
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
        //getMusicData(playlistID: playlistIDVar)
        let url = URL(string: self.playlist.mp3URLs[position])
        playerItem = AVPlayerItem(url:url!)
        player = AVPlayer(playerItem:playerItem!)
        let playerLayer = AVPlayerLayer(player:player!)
        playerLayer.frame = CGRect(x: 0, y: 0, width: 10, height: 50)
        self.view.layer.addSublayer(playerLayer)
    }
    //Draws buttons in my Holder View
    func drawButtons(){
        //set button position
        let size:CGFloat = 80
        playPauseButton.frame = CGRect(x: (holder.frame.size.width - size)/2.0, y: 200, width: size, height: size)
//        forwardButton.frame = CGRect(x: holder.frame.size.width - size - 20, y: 200, width: size, height: size)
//        backButton.frame = CGRect(x: 20, y: 200, width: size, height: size)
        
        // set button image
        playPauseButton.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
//        forwardButton.setBackgroundImage(UIImage(systemName: "forward.fill"), for: .normal)
//        backButton.setBackgroundImage(UIImage(systemName: "backward.fill"), for: .normal)
//
        //set button color
        playPauseButton.tintColor = UIColor(named:"logo")
//        backButton.tintColor = .blue
//        forwardButton.tintColor = .blue
        
        //set button
        holder.addSubview(playPauseButton)
//        holder.addSubview(forwardButton)
//        holder.addSubview(backButton)
        
        // calls button functionality
        playPauseButton.addTarget(self, action: #selector(didPressPlayPauseButton), for: .touchUpInside)
//        backButton.addTarget(self, action: #selector(didPressBackButton), for: .touchUpInside)
//        forwardButton.addTarget(self, action: #selector(didPressForwardButton), for: .touchUpInside)
    }
    // last song
//    @objc func didPressBackButton(){
//        if position < playlist.songTitles.count - 1 {
//            print("backbutton")
//            position = position + 1
//            player?.pause()
//            progressBar.setProgress(0.0, animated: true)
//            myTime = 0
//            startTime.text = "00:00"
//            timer.invalidate()
//            configure()
//        }
//
//    }
//    //next song
//    @objc func didPressForwardButton(){
//        print("nextbutton")
//        if position > 0 {
//            position = position - 1
//            player?.pause()
//            progressBar.setProgress(0.0, animated: true)
//            myTime = 0
//            startTime.text = "00:00"
//            timer.invalidate()
//            configure()
//        }
//
//    }
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
    // converts seconds to minutes for timer functionality
    func secondsToMinutes(seconds: Int) ->(Int, Int){
            return (((seconds % 3600) / 60),((seconds % 3600) % 60))
        }
    //function to update time
    @objc func updateTime(){
       
//        if(startTime.text! != resultTime.text!){
//            myTime  = myTime + 1
//
//            let time = secondsToMinutes(seconds:myTime + 1)
//            startTime.text = String(format:"%02d",time.0) + ":" + String(format: "%02d",time.1)
//
//            guard let total = player?.duration else{
//                return
//            }
//            progressBar.setProgress(Float(myTime)*Float(1/total.rawValue),animated:true)
//        }
//
    }
}


//extension MusicViewController : UICollectionViewDelegateFlowLayout{
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 375, height: 375)
//    }
//
//}



