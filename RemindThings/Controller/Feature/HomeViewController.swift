//
//  HomeViewController.swift
//  RemindThings
//
//  Created by NganHa on 4/19/20.
//  Copyright © 2020 Galaxy. All rights reserved.
//

import UIKit
import Firebase
class HomeViewController: UIViewController {
   
    @IBOutlet weak var countDownBtn: UIButton!
     
     @IBOutlet weak var diaryBtn: UIButton!
     
     @IBOutlet weak var listBtn: UIButton!
     
     @IBOutlet weak var remindBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserId()
        customButton(button: countDownBtn)
        customButton(button: diaryBtn)
        customButton(button: listBtn)
        customButton(button: remindBtn)
       
    }
    func getUserId(){
        if let user = Auth.auth().currentUser{
            User.id = user.uid
        }
         print("THE USER ID IS \(User.id)")
    }
    func customButton(button: UIButton){
        button.layer.cornerRadius = 15
        
    }
   
 
    
    
    

  
}
