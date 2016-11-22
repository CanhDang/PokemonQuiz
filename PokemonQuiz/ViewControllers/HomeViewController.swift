//
//  HomeViewController.swift
//  PokemonQuiz
//
//  Created by Enrik on 11/17/16.
//  Copyright © 2016 Enrik. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    
    
    var currentScore: Int!
    
    @IBOutlet weak var lastScoreLabel: UILabel!
    
    @IBOutlet weak var highScoreLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if UserDefaults.standard.value(forKey: Constant.Setting.IsMusic) == nil {
            UserDefaults.standard.set(true, forKey: Constant.Setting.IsMusic)
            UserDefaults.standard.set(true, forKey: Constant.Setting.IsSound)
            UserDefaults.standard.set([1], forKey: Constant.Setting.Gens)
        }
 
    }
    
    func playButtonSound() {
        if UserDefaults.standard.value(forKey: Constant.Setting.IsSound) as! Bool == true {
            Audio.sharedInstance.playSound(name: Constant.Music.ButtonSoundName, exten: Constant.Music.ButtonSoundExten)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if currentScore != nil {
            setScore()
        } else {
            if let lastScore = UserDefaults.standard.value(forKey: Constant.Score.LastScore) as? Int {
                self.lastScoreLabel.text = String(lastScore)
            } else {
                self.lastScoreLabel.text = "0"
            }
            
            if let lastHighScore = UserDefaults.standard.value(forKey: Constant.Score.HighScore) as? Int {
                self.highScoreLabel.text = Constant.Score.HighScore + String(lastHighScore)
            } else {
                self.highScoreLabel.text = Constant.Score.HighScore
            }

        }
        
        if UserDefaults.standard.value(forKey: Constant.Setting.IsMusic) as! Bool == true {
            Audio.sharedInstance.playMusic(name: Constant.Music.HomeMusic, exten: Constant.Music.HomeMusicExten)
        }
    }

    
    func setScore() {
        UserDefaults.standard.setValue(self.currentScore, forKey: Constant.Score.LastScore )
        
        if UserDefaults.standard.value(forKey: Constant.Score.HighScore) ==  nil {
            
            UserDefaults.standard.setValue(self.currentScore, forKey: Constant.Score.HighScore)
            
            self.lastScoreLabel.text = String(self.currentScore)
            
            self.highScoreLabel.text = Constant.Score.NewHighScore
            
        } else {
            let lastHighScore = UserDefaults.standard.value(forKey: Constant.Score.HighScore) as! Int
            
            if self.currentScore > lastHighScore {
                UserDefaults.standard.setValue(self.currentScore, forKey: Constant.Score.HighScore)
                self.highScoreLabel.text = Constant.Score.NewHighScore
            } else {
                self.highScoreLabel.text = Constant.Score.HighScore + ": " + String(lastHighScore)
            }
            
            self.lastScoreLabel.text = String(self.currentScore)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func invokePlayView(_ sender: AnyObject) {
        
        self.playButtonSound()
        
        let playVC = self.storyboard?.instantiateViewController(withIdentifier: "PlayViewController") as! PlayViewController
        playVC.transferScoreDelegate = self
        
        navigationController?.pushViewController(playVC, animated: true)
        
    }
    
    @IBAction func invokeSettingView(_ sender: AnyObject) {
        
        self.playButtonSound()
        
        let settingVC = self.storyboard?.instantiateViewController(withIdentifier: "SettingViewController")
        
        navigationController?.pushViewController(settingVC!, animated: true)
    }
    
}

extension HomeViewController: TransferScore {
    
    func transferScore(score: Int) {
        self.currentScore = score
    }
    
}


