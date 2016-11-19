//
//  PlayViewController.swift
//  PokemonQuiz
//
//  Created by Enrik on 11/17/16.
//  Copyright © 2016 Enrik. All rights reserved.
//

import UIKit

class PlayViewController: UIViewController {

    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .lightContent

        for button in self.buttonAnswers {
            button.layer.cornerRadius = 20
        }
        self.imageView.layer.cornerRadius = 5
        
        self.initGame()
        
        self.progressView.updateProgress(1, animated: true, initialDelay: 0, duration: 10) { 
            for button in self.buttonAnswers {
                button.isUserInteractionEnabled = false
            }
            if self.isAnswered == false {
                self.showRealImage()
                
            }
        }
    }
    
    func initImageView() {
        self.pokemonImage = UIImage(named: "test")
        self.imageView.contentMode = .scaleAspectFit
        self.imageView.image = self.imageView.image?.withRenderingMode(.alwaysTemplate)
    }
    
    func initGame() {
        initImageView()
        self.pokemonCodeLabel.isHidden = true
        self.pokemonName = "Pikachu"
        self.pokemonCode = "#001"
        initButton()
    
    }
    
    func initButton() {
        self.rightTag = 101
        
        for button in buttonAnswers {
            if button.tag == 101 {
                button.setTitle("Pikachu", for: .normal)
            }
            if button.tag == 102 {
                button.setTitle("Khong bit", for: .normal)
            }
            if button.tag == 103 {
                button.setTitle("Con heo", for: .normal)
            }
            if button.tag == 104 {
                button.setTitle("Con meo", for: .normal)
            }
        }
    }
    
    @IBAction func actionBack(_ sender: AnyObject) {
        navigationController?.popViewController(animated: true)
    }
    
    func showRealImage() {
        self.imageView.image = self.imageView.image?.withRenderingMode(.alwaysOriginal)
        self.imageView.tintColor = UIColor.black
        
        self.pokemonCodeLabel.text = pokemonCode + "-" + pokemonName
        self.pokemonCodeLabel.isHidden = false
    }
    
    @IBAction func actionAnswer(_ sender: UIButton) {
        self.showRealImage()
        if sender.titleLabel?.text == self.pokemonName {
            sender.backgroundColor = UIColor.green
            self.score += 1
            self.scoreLabel.text = String(self.score)
        } else {
            sender.backgroundColor = UIColor.red
            for button in self.buttonAnswers {
                if button.tag == self.rightTag {
                    button.backgroundColor = UIColor.green
                    break
                }
            }
        }
        self.isAnswered = true
        for button in self.buttonAnswers {
            button.isUserInteractionEnabled = false
        }
    }
    
}
