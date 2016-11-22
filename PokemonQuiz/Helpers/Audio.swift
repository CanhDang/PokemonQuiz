//
//  Audio.swift
//  PokemonQuiz
//
//  Created by Enrik on 11/21/16.
//  Copyright © 2016 Enrik. All rights reserved.
//

import AVFoundation
import AudioToolbox

class Audio {
    static let sharedInstance = Audio()
    
    var player: AVAudioPlayer?
    
    func playMusic(name: String, exten: String) {
        let url = Bundle.main.url(forResource: name, withExtension: exten)!
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }
            
            player.prepareToPlay()
            player.play()
            
            player.numberOfLoops = -1
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func playSound(name: String, exten: String) {
        var soundID: SystemSoundID = 0
        let filePath = Bundle.main.path(forResource: name, ofType: exten)
        let soundURL = NSURL(fileURLWithPath: filePath!)
        AudioServicesCreateSystemSoundID(soundURL, &soundID)
        AudioServicesPlaySystemSound(soundID)
    }
    
}

