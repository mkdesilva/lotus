//
//  AudioController.swift
//  Lotus
//
//  Created by Mihindu de Silva on 10/5/21.
//  Copyright © 2021 Mihindu de Silva. All rights reserved.
//

import AVFoundation

var player: AVAudioPlayer?

class AudioController {
  func playAudio(fileName: String, fileExtension: String = "wav") {
    guard let url = Bundle.main.url(forResource: fileName, withExtension: fileExtension) else {
      print("url not found")
      return
    }
    
    do {
      try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
      try AVAudioSession.sharedInstance().setActive(true)
      
      player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.wav.rawValue)
      
      guard let audioPlayer = player else {
        print("Audio Player does not exist. Check the implementation of SessionInProgressViewController.swift line 102")
        return
      }
      audioPlayer.play()
    } catch let error as NSError {
      print("error: \(error.localizedDescription)")
    }
  }
  
  func disableAudioSession() {
    try? AVAudioSession.sharedInstance().setActive(false)
  }
}
