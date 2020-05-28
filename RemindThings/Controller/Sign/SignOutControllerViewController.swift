//
//  SignOutControllerViewController.swift
//  RemindThings
//
//  Created by NganHa on 4/22/20.
//  Copyright © 2020 Galaxy. All rights reserved.
//

import UIKit
import Firebase

class SignOutControllerViewController: UIViewController {

    var appDel: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        alertSignOut()
        // Do any additional setup after loading the view.
    }
    
    func alertSignOut(){
        let alert = UIAlertController(title: "Bạn có muốn đăng xuất không ?", message: "", preferredStyle: .alert)
        let actionYes = UIAlertAction(title: "OK", style: .default) { (actionYes) in
            let firebaseAuth = Auth.auth()
            do {
              try firebaseAuth.signOut()
            } catch let signOutError as NSError {
              print ("Error signing out: %@", signOutError)
            }
            User.id = ""
            UserDefaults.standard.set(false, forKey: "isAuth")
            UserDefaults.standard.synchronize()
            DispatchQueue.main.async {
                if let myDelgate = UIApplication.shared.delegate as? AppDelegate {
                    myDelgate.navigate(K.ScreenName.startScreen)
                }
            }
        }
        let actionNo = UIAlertAction(title: "Huỷ", style: .default) { (actionNo) in
           DispatchQueue.main.async {
                          if let myDelgate = UIApplication.shared.delegate as? AppDelegate {
                                             myDelgate.navigate(K.ScreenName.TabBarController)
                                         }
                      }
           
        }
        alert.addAction(actionYes)
        alert.addAction(actionNo)
        present(alert, animated: true, completion: nil)
    
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
