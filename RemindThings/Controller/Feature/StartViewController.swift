//
//  HomeViewController.swift
//  RemindThings
//
//  Created by NganHa on 4/19/20.
//  Copyright © 2020 Galaxy. All rights reserved.
//

import UIKit


class StartViewController: UIViewController {

    @IBOutlet weak var remindLabel: UILabel!
    
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()

        animationLabel()
    }
        
    @IBAction func signUpPressed(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(identifier: K.ScreenName.signUp) as! SignUpViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func signInPressed(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: K.ScreenName.signIn) as! SignInViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func animationLabel(){
        remindLabel.text = ""
        var charIndex = 0.0
        let titleIndex = "🔔 Remind Things"
        for letter in titleIndex {
            Timer.scheduledTimer(withTimeInterval: 0.1*charIndex, repeats: false) { (timer) in
                self.remindLabel.text?.append(letter)
            }
            charIndex += 1
        }
//    
    }
    }
    
    
 


