//
//  Buttons.swift
//  TakeItEasy
//
//  Created by Matt Caulder on 6/13/22.
//

import Foundation

class drawPlaybackButtons{
    func drawButtons(){
        let size:CGFloat = 80
        playPauseButton.frame = CGRect(x: (holder.frame.size.width - size)/2.0, y: 200, width: size, height: size)
        forwardButton.frame = CGRect(x: holder.frame.size.width - size - 20, y: 200, width: size, height: size)
        backButton.frame = CGRect(x: 20, y: 200, width: size, height: size)
        
        playPauseButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
        forwardButton.setBackgroundImage(UIImage(systemName: "forward.fill"), for: .normal)
        backButton.setBackgroundImage(UIImage(systemName: "backward.fill"), for: .normal)
        
        playPauseButton.tintColor = .blue
        backButton.tintColor = .blue
        forwardButton.tintColor = .blue
        
        
        
//        playPauseButton.addTarget(self, action: #selector(didPressPlayPauseButton), for: .touchUpInside)
//        backButton.addTarget(self, action: #selector(didPressForwardButton), for: .touchUpInside)
//        forwardButton.addTarget(self, action: #selector(didPressBackButton), for: .touchUpInside)
        
        holder.addSubview(playPauseButton)
        holder.addSubview(forwardButton)
        holder.addSubview(backButton)
    }
}
