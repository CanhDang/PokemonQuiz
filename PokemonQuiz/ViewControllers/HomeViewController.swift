//
//  HomeViewController.swift
//  PokemonQuiz
//
//  Created by Enrik on 11/17/16.
//  Copyright © 2016 Enrik. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func invokePlayView(_ sender: AnyObject) {
        
        let playVC = self.storyboard?.instantiateViewController(withIdentifier: "PlayViewController")
        
        navigationController?.pushViewController(playVC!, animated: true)
        
    }
    
    @IBAction func invokeSettingView(_ sender: AnyObject) {
        
        let settingVC = self.storyboard?.instantiateViewController(withIdentifier: "SettingViewController")
        
        navigationController?.pushViewController(settingVC!, animated: true)
    }
    


}
