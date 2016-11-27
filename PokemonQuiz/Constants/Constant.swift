//
//  Constant.swift
//  PokemonQuiz
//
//  Created by Enrik on 11/21/16.
//  Copyright © 2016 Enrik. All rights reserved.
//

import Foundation

struct Constant {
    
    struct Setting {
        static let IsSound = "isSound"
        static let IsMusic = "isMusic"
        static let Gens = "gens"
    }
    
    struct Score {
        static let LastScore = "LAST SCORE"
        static let HighScore = "HIGH SCORE "
        static let NewHighScore = "NEW HIGH SCORE"
    }
    
    struct Music {
        static let SwitchSoundName = "UIToggle"
        static let ButtonSoundName = "UIClick"
        static let HomeMusic = "Quirky-Puzzle-Game-Menu"
        static let SettingMusic = "Quirky-Puzzle-Game-Menu"
        static let PlayMusic = "8-Bit-Mayhem"
        static let RightSound = "firered_00FA"
        static let WrongSound = "firered_00A3"
        
        static let SwitchSoundExten = "wav"
        static let ButtonSoundExten = "wav"
        static let HomeMusicExten = "mp3"
        static let SettingMusicExten = "mp3"
        static let PlayMusicExten = "mp3"
        static let RightSoundExten = "wav"
        static let WrongSoundExten = "wav"
    }
    
    struct PlayVC {
        static let PlayTime: Double = 30
        static let ShowImageDelay: Double = 0.7
        static let ShowAnswerDelay: Double = 0.5
    }
}
