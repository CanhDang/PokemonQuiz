//
//  PlayViewController.swift
//  PokemonQuiz
//
//  Created by Enrik on 11/17/16.
//  Copyright © 2016 Enrik. All rights reserved.
//

import UIKit

protocol TransferScore: class {
    func transferScore(score : Int)
}

class PlayViewController: UIViewController {
    
    var transferScoreDelegate: TransferScore!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet var buttonAnswers: [UIButton]!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var pokemonCodeLabel: UILabel!
    
    @IBOutlet weak var progressView: RPCircularProgress!
    
    var score: Int = 0
    
    var pokemonImage: UIImage!
    var pokemonName: String!
    var pokemonCode: String!
    
    var rightTag: Int!
    var isAnswered: Bool = false
    
    var listPokemon = [Pokemon]()
    var playedPokemon = [Int]()
    var listGens = [Int]()
    
    var randomIndex: Int!
    
    var isMusic: Bool = false
    var isSound: Bool = false
    
    var isBack: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .lightContent
        
        self.initMusic()
        self.initListPokemon()
        
        for button in self.buttonAnswers {
            button.layer.cornerRadius = 20
        }
        self.imageView.layer.cornerRadius = 5
        
        self.progressView.updateProgress(1, animated: true, initialDelay: 0, duration: Constant.PlayVC.PlayTime) {
            
            for button in self.buttonAnswers {
                button.isUserInteractionEnabled = false
            }
            
            if self.isAnswered == false {
                self.showRealImage()
            }
            if !self.isBack {
                self.navigationController!.popViewController(animated: true)
            }
            
            self.transferScoreDelegate.transferScore(score: self.score)
            
        }
        self.newSet()
    }
    
    func initMusic() {
        
        self.isMusic = UserDefaults.standard.value(forKey: Constant.Setting.IsMusic) as! Bool
        self.isSound = UserDefaults.standard.value(forKey: Constant.Setting.IsSound) as! Bool
        
        if self.isMusic == true {
            Audio.sharedInstance.playMusic(name: Constant.Music.PlayMusic, exten: Constant.Music.PlayMusicExten)
        }
        
    }
    
    
    func initListPokemon() {
        self.playedPokemon.removeAll()
        
        self.listPokemon.removeAll()
        
        let gens = UserDefaults.standard.value(forKey: Constant.Setting.Gens) as! [Int]
        
        for gen in gens {
            let listGen = DataManager.defaultManager.selectPokemon(gen: gen)
            self.listPokemon.append(contentsOf: listGen)
        }
        
    }
    
    func newSet() {
        
        self.randomPokemon()
        self.initImageView()
        self.initButton()
        
    }
    
    func randomPokemon() {
        
        var randomNumber = -1
        var isPlayed = true
        
        while isPlayed {
            isPlayed = false
            randomNumber = Int(arc4random_uniform(UInt32(self.listPokemon.count)))
            for number in playedPokemon {
                if randomNumber == number {
                    isPlayed = true
                    break
                }
            }
        }
        
        self.playedPokemon.append(randomNumber)
        self.pokemonName = self.listPokemon[randomNumber].name
        self.pokemonImage = UIImage(named: self.listPokemon[randomNumber].img)
        self.pokemonCode = self.listPokemon[randomNumber].tag
        
        var randomButton = -1
        
        randomButton = Int(arc4random_uniform(4))
        
        self.buttonAnswers[randomButton].setTitle(pokemonName, for: .normal)
        self.rightTag = self.buttonAnswers[randomButton].tag
        
        var chosenIDs = [randomNumber]
        
        for (index,button) in buttonAnswers.enumerated() {
            if index != randomButton {
                
                var randomNo = randomNumber
                
                while chosenIDs.contains(randomNo) {
                    
                    randomNo = Int(arc4random_uniform(UInt32(self.listPokemon.count)))
                    
                }
                chosenIDs.append(randomNo)
                
                button.setTitle(listPokemon[randomNo].name, for: .normal)
            }
        }
        
    }
    
    func initButton() {
        for button in buttonAnswers {
            button.backgroundColor = UIColor.white
        }
        for button in self.buttonAnswers {
            button.isUserInteractionEnabled = true
        }
    }
    
    func initImageView() {

        let originPoint = self.imageView.frame.origin
        let frame = self.imageView.frame
        print(self.imageView.frame)
        
        UIView.animate(withDuration: 1, delay: 0, options: [.curveEaseOut], animations: {
            
           // self.imageView.frame = CGRect(x: -frame.width, y: originPoint.y, width: frame.width, height: frame.height)
            
            self.imageView.center.x = 0 - self.imageView.frame.width
            
            print(self.imageView.frame)
            
            }) { (completed) in
                
//                self.imageView.frame = CGRect(x: self.view.frame.width, y: originPoint.y, width: frame.width, height: frame.height)
//                
//                UIView.animate(withDuration: 1, delay: 0.1, options: .curveEaseIn, animations: {
//                    
//                    self.imageView.frame = CGRect(x: originPoint.x, y: originPoint.y, width: frame.width, height: frame.height)
//                    
//
//                    
//                    }, completion: { (completed) in
//                        
//                        
//                        
//                })
                
        }
        
        self.imageView.contentMode = .scaleAspectFit
        self.imageView.image = self.pokemonImage.withRenderingMode(.alwaysTemplate)
        
        self.pokemonCodeLabel.isHidden = true
    }
    
    @IBAction func actionBack(_ sender: AnyObject) {
        
        self.isBack = true
        
        self.navigationController!.popViewController(animated: true)
        
        self.transferScoreDelegate.transferScore(score: self.score)
    }
    
    func showRealImage() {
        UIView.transition(with: self.imageView, duration: Constant.PlayVC.ShowImageDelay, options: [.transitionFlipFromRight], animations: {
            
            self.imageView.image = self.imageView.image?.withRenderingMode(.alwaysOriginal)
            self.imageView.tintColor = UIColor.black
            
            }, completion: { (bool) in
                self.pokemonCodeLabel.text = self.pokemonCode + "-" + self.pokemonName
                self.pokemonCodeLabel.isHidden = false

                self.delay(0.2, closure: {
                    
                    self.newSet()
                    
                })
        })
        

        
    }
    
    @IBAction func actionAnswer(_ sender: UIButton) {
        
        self.showRealImage()
        
        delay(Constant.PlayVC.ShowAnswerDelay) {
            
            if sender.titleLabel?.text == self.pokemonName {
                sender.backgroundColor = UIColor.green
                self.score += 1
                self.scoreLabel.text = String(self.score)
                
                
                if self.isSound == true {
                    Audio.sharedInstance.playSound(name: Constant.Music.RightSound, exten: Constant.Music.RightSoundExten)
                }
                
                
            } else {
                sender.backgroundColor = UIColor.red
                for button in self.buttonAnswers {
                    if button.tag == self.rightTag {
                        button.backgroundColor = UIColor.green
                        break
                    }
                }
                
                if self.isSound == true {
                    Audio.sharedInstance.playSound(name: Constant.Music.WrongSound, exten: Constant.Music.WrongSoundExten)
                }
                
            }
            self.isAnswered = true
            
            for button in self.buttonAnswers {
                button.isUserInteractionEnabled = false
            }
            
        }
        
    }
    
    func delay(_ delay:Double, closure:@escaping ()->()) {
        let when = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
    }
}
