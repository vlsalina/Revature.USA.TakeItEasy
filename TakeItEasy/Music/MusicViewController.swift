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
    var songs = [Song]()
    //button view
    @IBOutlet var holder:UIView!
    
    public var position:Int = 4
    //timers
    public var myTime: Int = 0
    public var timer = Timer()
    
    //playbackbuttons
    let playPauseButton = UIButton()
    let backButton = UIButton()
    let forwardButton = UIButton()
    
    //allows audio
    var player:AVAudioPlayer?
    
    // progressbar
    @IBOutlet var progressBar: UIProgressView!
    @IBOutlet var startTime:UILabel!
    @IBOutlet var resultTime:UILabel!
    
    // label name
    private let songNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return songs.count
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let position = indexPath.row
        print(position)
               
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "musicCell", for: indexPath)
        cell.backgroundColor = UIColor.red
        return cell
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSongs()
        configure()
        drawButtons()
        drawSlider()
    }
    func configure(){
//        let song = songs[position]
//        let urlString = Bundle.main.path(forResource: song.trackName, ofType: "mp3")
//        do{
//            try AVAudioSession.sharedInstance().setMode(.default)
//            try AVAudioSession.sharedInstance().setActive(true,options:.notifyOthersOnDeactivation)
//            guard let urlString = urlString else{
//                return
//            }
//            player = try AVAudioPlayer(contentsOf:URL(string:urlString)!)
//            guard let player = player else{
//                return
//            }
//            player.volume = 0.5
//
//            player.play()
//            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
//            let time = secondsToMinutes(seconds: Int(player.duration))
//            resultTime.text = String(format: "%02d", time.0) + ":" + String(format: "%02d", time.1)
//            }catch{
//           print("Error")
//            }
    }
    //Draws buttons in my Holder View
    func drawButtons(){
        //set button position
        let size:CGFloat = 80
        playPauseButton.frame = CGRect(x: (holder.frame.size.width - size)/2.0, y: 200, width: size, height: size)
        forwardButton.frame = CGRect(x: holder.frame.size.width - size - 20, y: 200, width: size, height: size)
        backButton.frame = CGRect(x: 20, y: 200, width: size, height: size)
        
        // set button image
        playPauseButton.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
        forwardButton.setBackgroundImage(UIImage(systemName: "forward.fill"), for: .normal)
        backButton.setBackgroundImage(UIImage(systemName: "backward.fill"), for: .normal)
        
        //set button color
        playPauseButton.tintColor = .blue
        backButton.tintColor = .blue
        forwardButton.tintColor = .blue
        
        //set button
        holder.addSubview(playPauseButton)
        holder.addSubview(forwardButton)
        holder.addSubview(backButton)
        
        // calls button functionality
        playPauseButton.addTarget(self, action: #selector(didPressPlayPauseButton), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(didPressBackButton), for: .touchUpInside)
        forwardButton.addTarget(self, action: #selector(didPressForwardButton), for: .touchUpInside)
    }
    //draw slider function
    func drawSlider(){
        let slider = UISlider(frame:CGRect(x: 20, y: holder.frame.size.height-60, width: holder.frame.size.width-40, height: -150))
        holder.addSubview(slider)
        slider.value=0.5
        slider.addTarget(self, action: #selector(didSlideSlider(_:)), for: .valueChanged)
        
        holder.addSubview(slider)
    }
    // volume slider
    @objc func didSlideSlider(_ slider: UISlider){
        let value = slider.value
        player?.volume = value
        
    }
    // last song
    @objc func didPressBackButton(){
        if position < songs.count - 1 {
            position = position + 1
            player?.stop()
            progressBar.setProgress(0.0, animated: true)
            myTime = 0
            startTime.text = "00:00"
            timer.invalidate()
                    
            configure()
        }

    }
    //next song
    @objc func didPressForwardButton(){
        print("nextbutton")
        if position > 0 {
            position = position - 1
            player?.stop()
            progressBar.setProgress(0.0, animated: true)
                    myTime = 0
                    startTime.text = "00:00"
                    timer.invalidate()
                    configure()
        }
        
    }
    //play pause functionaility
    @objc func didPressPlayPauseButton(){
        if (player?.isPlaying != true){
            print("pauseButton")
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
            player?.play()
            playPauseButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)

        }else{
            player?.pause()
            timer.invalidate()
            print("playbutton")
            playPauseButton.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
            
        }
    }
    
    // if view closes music will stop too
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let player = player{
            player.stop()
        }
    }
    // converts seconds to minutes for timer functionality
    func secondsToMinutes(seconds: Int) ->(Int, Int){
            return (((seconds % 3600) / 60),((seconds % 3600) % 60))
        }
    //function to update time
    @objc func updateTime(){
       
        if(startTime.text! != resultTime.text!){
            myTime  = myTime + 1
            
            let time = secondsToMinutes(seconds:myTime + 1)
            startTime.text = String(format:"%02d",time.0) + ":" + String(format: "%02d",time.1)
            
            guard let total = player?.duration else{
                return
            }
            progressBar.setProgress(Float(myTime)*Float(1/total),animated:true)
        }
        
    }
}


extension MusicViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 300)
    }
    func configureSongs(){
        songs.append(Song(name: "As You Fade Away", artistName: "NEFFEX", imageName: "1", trackName: "s1"))
        songs.append(Song(name: "Enough", artistName: "NEFFEX", imageName: "2", trackName: "s2"))
        songs.append(Song(name: "Get Through", artistName: "NEFFEX", imageName: "3", trackName: "s3"))
        songs.append(Song(name: "Good Day (Wake Up)", artistName: "NEFFEX", imageName: "4", trackName: "s4"))
        songs.append(Song(name: "Go!", artistName: "NEFFEX", imageName: "5", trackName: "s5"))

    }

}

struct Song {
    let name: String
    let artistName: String
    let imageName: String
    let trackName: String
}

