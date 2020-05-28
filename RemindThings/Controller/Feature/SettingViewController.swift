//
//  SettingViewController.swift
//  RemindThings
//
//  Created by NganHa on 4/22/20.
//  Copyright © 2020 Galaxy. All rights reserved.
//

import UIKit
import Firebase
class SettingViewController: UIViewController {
    
    let db = Firestore.firestore()
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var currentPassText: UITextField!
    @IBOutlet weak var newPassText: UITextField!
    @IBOutlet weak var newPass2Text: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        getUsername()
        getInfo()
        // tap keyboard
        initializeHideKeyboard()
        
        // Do any additional setup after loading the view.
    }
    //MARK: catch some error
    func checkinputError() -> Bool{
        if currentPassText.text!.isBlank || newPassText.text!.isBlank || newPass2Text.text!.isBlank {
            alertFail(with: "Bạn phải điền tất cả thông tin")
            return false
        }
       else if newPassText.text! != newPass2Text.text!{
            alertFail(with: "Mật khẩu mới phải giống mật khẩu nhập lại")
            return false
        }
        else {
            return true
        }
    }
    func alertFail(with note: String){
        let alert = UIAlertController(title: "Đổi mật khẩu thất bại", message: note, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            self.currentPassText.text = ""
            self.newPass2Text.text = ""
            self.newPassText.text = ""
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    func alertSuccess(){
    let alert = UIAlertController(title: "Đổi mật khẩu thành công", message: "", preferredStyle: .alert)
    let action = UIAlertAction(title: "OK", style: .default) { (action) in
        self.currentPassText.text = ""
        self.newPass2Text.text = ""
        self.newPassText.text = ""
    }
    alert.addAction(action)
    present(alert, animated: true, completion: nil)    }
    
    //MARK: change Pass
    func changePass(){
    if let currentUser = Auth.auth().currentUser {
      // User is signed in.
        if currentPassText.text! == currentUser.value(forUndefinedKey: "password") as! String {
           if checkinputError() == true {
                currentUser.updatePassword(to: currentPassText.text!) { (error) in
                         if error != nil {
                            print("khong the update pass: \(error?.localizedDescription ?? "nothing")")
                         }
                }
                
            
            }
            alertSuccess()
         
        } else {
            alertFail(with: "Mật khẩu hiện tại không đúng")
        
        }
    }
    }
    
    func getUsername(){
       if let currentUser = Auth.auth().currentUser{
        usernameText.text = currentUser.email
        }
    }
    func  getInfo() {
        if let user = Auth.auth().currentUser{
            User.id = user.uid
        let docRef = db.collection("user").document(User.id)

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
            } else {
                print("Document does not exist")
            }
        }
    }
    }
    @IBAction func acceptPressed(_ sender: Any) {
        changePass()
    }
}
