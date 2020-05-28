//
//  ViewController.swift
//  RemindThings
//
//  Created by NganHa on 4/18/20.
//  Copyright © 2020 Galaxy. All rights reserved.
//

import UIKit
import Firebase
class SignInViewController: UIViewController{
    var appDel: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    @IBOutlet weak var passwordText: UITextField!{
    didSet {
       passwordText.tintColor = UIColor.lightGray
        passwordText.setIcon(#imageLiteral(resourceName: "Key-icon"))
    
    }
    }
    @IBOutlet weak var usernameText: UITextField!{
    didSet {
       usernameText.tintColor = UIColor.lightGray
        usernameText.setIcon(#imageLiteral(resourceName: "person-male"))
    }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Đăng nhập"
        // tap keyboard
        initializeHideKeyboard()
    }


    @IBAction func signinPressed(_ sender: UIButton) {
        if usernameText.text == nil || passwordText.text == nil {
            let alertFail = UIAlertController(title: "Đăng nhập thất bại", message: "Bạn phải điền đầy đủ thông tin", preferredStyle: .alert)
            present(alertFail, animated: true, completion: nil)
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when){
               
                alertFail.dismiss(animated: true, completion: nil)
            }
        
        }
        if let email = usernameText.text, let password = passwordText.text{
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            if error != nil {
            let alertFail = UIAlertController(title: "Đăng nhập thất bại", message: "Email hoặc mật khẩu không chính xác", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default) { (action) in
                    self!.usernameText.text = nil
                    self!.passwordText.text = nil
                }
                alertFail.addAction(action)
                self!.present(alertFail, animated: true, completion: nil)
            }
        else {
                if let user = authResult?.user{
                    User.id = user.uid
                }
                UserDefaults.standard.set(true, forKey: "isAuth")
                UserDefaults.standard.synchronize()
                let alert = UIAlertController(title: "Đăng nhập thành công", message: "", preferredStyle: .alert)
                self?.present(alert, animated: true, completion: nil)
                let when = DispatchTime.now() + 0.5
                DispatchQueue.main.asyncAfter(deadline: when){
                    // your code with delay
                    alert.dismiss(animated: true, completion: {
                        if let myDelegate = UIApplication.shared.delegate as? AppDelegate {
                            myDelegate.navigate(K.ScreenName.TabBarController)
                        }
                    })
                }
            }
        }
            
        
       
        }
    }
    
    @IBAction func facebookPressed(_ sender: UIButton) {
    }
    
    @IBAction func googlePressed(_ sender: UIButton) {
    }
    
//    @IBAction func signupPressed(_ sender: UIButton) {
////        self.performSegue(withIdentifier: K.Segue.SignInToSignUp, sender: self)
//    }
   
  
   
}




 



