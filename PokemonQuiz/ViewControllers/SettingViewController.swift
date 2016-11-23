//
//  SettingViewController.swift
//  PokemonQuiz
//
//  Created by Enrik on 11/20/16.
//  Copyright © 2016 Enrik. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

  
    @IBOutlet weak var switchSound: UISwitch!
    
    @IBOutlet weak var switchMusic: UISwitch!
    
    
    @IBOutlet var buttonGenerations: [UIButton]!
    
    var isSound: Bool!
    var isMusic: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.statusBarStyle = .default
    
        self.initSwitches()
        
        self.initButtons()

    }
    
    func initSwitches(){
        switchSound.transform = .init(scaleX: 0.8, y: 0.8)
        switchMusic.transform = .init(scaleX: 0.8, y: 0.8)
        
        if UserDefaults.standard.value(forKey: Constant.Setting.IsMusic) as! Bool == true {
            self.switchMusic.isOn = true
            
            Audio.sharedInstance.playMusic(name: Constant.Music.SettingMusic, exten: Constant.Music.SettingMusicExten)
            self.isMusic = true
        } else {
            self.switchMusic.isOn = false
            self.isMusic = false
        }
        
        if UserDefaults.standard.value(forKey: Constant.Setting.IsSound) as! Bool == true {
            self.switchSound.isOn = true
            self.isSound = true
        } else {
            self.switchSound.isOn = false
            self.isSound = false
        }
        
    }
    
    func initButtons() {
        let listGens = UserDefaults.standard.value(forKey: Constant.Setting.Gens) as! [Int]
        
        for button in buttonGenerations {
            button.alpha = 0.5 
        }
        
        for gen in listGens {
            for button in buttonGenerations {
                if button.tag == (gen + 200) {
                    button.alpha = 1
                    break
                }
            }
        }
    }

    @IBAction func actionBackView(_ sender: AnyObject) {
        self.navigationController!.popViewController(animated: true)
        
        if self.isSound == true {
            Audio.sharedInstance.playSound(name: Constant.Music.ButtonSoundName, exten: Constant.Music.ButtonSoundExten)
        }
        var gens = [Int]()
        for button in buttonGenerations {
            if button.alpha == 1 {
                gens.append(button.tag - 200)
            }
        }
        UserDefaults.standard.set(gens, forKey: Constant.Setting.Gens)
        UserDefaults.standard.set(self.isMusic, forKey: Constant.Setting.IsMusic)
        UserDefaults.standard.set(self.isSound, forKey: Constant.Setting.IsSound)
    }
    
    @IBAction func actionSwitchSound(_ sender: AnyObject) {
        
        
        
        if self.switchSound.isOn == true {
            self.isSound = true
        } else {
            self.isSound = false
        }
        
        if self.isSound == true {
            Audio.sharedInstance.playSound(name: Constant.Music.SwitchSoundName, exten: Constant.Music.SwitchSoundExten)
        }
    }
    
    @IBAction func actionSwitchMusic(_ sender: AnyObject) {
        
        if self.isSound == true {
            Audio.sharedInstance.playSound(name: Constant.Music.SwitchSoundName, exten: Constant.Music.SwitchSoundExten)
        }
        
        if switchMusic.isOn == true {
            Audio.sharedInstance.playMusic(name: Constant.Music.SettingMusic, exten: Constant.Music.SettingMusicExten)
            self.isMusic = true
        } else {
            Audio.sharedInstance.player?.stop()
            self.isMusic = false
        }
    }
    
    
    @IBAction func actionGenClicked(_ sender: UIButton) {
        
        var isLast = true
            for button in buttonGenerations {
                if button.tag != sender.tag {
                    if button.alpha == 1 {
                      isLast = false
                      break
                    }
                }
            }
        
            if isLast == false {
                if self.isSound == true {
                    Audio.sharedInstance.playSound(name: Constant.Music.ButtonSoundName, exten: Constant.Music.ButtonSoundExten)
                }
                if sender.alpha == 1 {
                    sender.alpha = 0.5
                } else {
                    sender.alpha = 1
                }
            } else {
                if self.isSound == true {
                    Audio.sharedInstance.playSound(name: Constant.Music.WrongSound, exten: Constant.Music.WrongSoundExten)
                }
                
            }
    }
    
    
}
