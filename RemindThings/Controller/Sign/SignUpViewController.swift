//
//  SignUpControllerViewController.swift
//  RemindThings
//
//  Created by NganHa on 4/19/20.
//  Copyright © 2020 Galaxy. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {
    var appDel: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    
    
// MARK: IBOUlet

    @IBOutlet weak var password2Text: UITextField!{
    didSet{
        password2Text.tintColor = UIColor.lightGray
        password2Text.setIcon(#imageLiteral(resourceName: "phone"))
        }
    
    }
    @IBOutlet weak var passwordText: UITextField!
    {
    didSet{
        passwordText.tintColor = UIColor.lightGray
        passwordText.setIcon(#imageLiteral(resourceName: "Key-icon"))
        }
    }
    @IBOutlet weak var addressText: UITextField!{
    didSet{
    addressText.tintColor = UIColor.lightGray
    addressText.setIcon(#imageLiteral(resourceName: "address"))
    }
    }
    @IBOutlet weak var phoneText: UITextField!{
    didSet{
        phoneText.tintColor = UIColor.lightGray
        phoneText.setIcon(#imageLiteral(resourceName: "phone"))
        }}
    @IBOutlet weak var emailText: UITextField!{
    didSet{
        emailText.tintColor = UIColor.lightGray
        emailText.setIcon(#imageLiteral(resourceName: "email"))
        }}
    @IBOutlet weak var usernameText: UITextField!{
    didSet{
    usernameText.tintColor = UIColor.lightGray
    usernameText.setIcon(#imageLiteral(resourceName: "person-male"))
    }
    }
   
    //MARK: declare firestore
    let db = Firestore.firestore()
    var ref: DocumentReference? = nil
    var accept = false
    //MARK: VIew did load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // tap keyboard
        initializeHideKeyboard()
      
    }
    
    @IBAction func newAccountPressed(_ sender: UIButton) {
        signUp()
    }
    func signUp(){
        if usernameText.text!.isBlank || emailText.text!.isBlank || phoneText.text!.isBlank
            || password2Text.text!.isBlank || passwordText.text!.isBlank
            || addressText.text!.isBlank {
            alertFail(with: "Bạn phải điền tất cả thông tin")
        }
        
        else if emailText.text!.isEmail == false {
            alertFail(with: "Bạn phải điền đúng định dạng email")
        }
        else if phoneText.text!.isPhoneNumber == false {
            alertFail(with: "Bạn phải điền đúng định dạng số điện thoại")
        }
        else if passwordText.text != password2Text.text{
            alertFail(with: "Mật khẩu và Nhập lại mật khẩu phải giống nhau")
        }
        else {
            let newUser = User(username: usernameText.text!, phone: phoneText.text!, address: addressText.text!)
            createNewAccount(emailText.text!, passwordText.text!, newUser)
        }
    }
   
    func createNewAccount(_ userEmail: String,_ userPassword: String,_ newUser: User) {
    
        Auth.auth().createUser(withEmail: userEmail, password: userPassword) { authResult, error in
          if error != nil{
            if let e = error?.localizedDescription {
            if e == "The password must be 6 characters long or more" {
                self.alertFail(with: "Mật khẩu phải dài hơn 6 ký tự")
                }
            }
            else {
             self.alertFail(with: "Email đã tồn tại")
            }
            }
         else {
            if let user = authResult?.user {
                User.id = user.uid
                print(User.id)
            }
            self.saveNewInfor(newUser)
         }
            
        }
        
    }
    
    func saveNewInfor(_ newUser: User){
        print("LƯU THÀNH CÔNG")
        db.collection("user").document(User.id).setData([
            "username": newUser.username,
            "phone": newUser.phone,
            "address": newUser.address
            ]){ err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added with ID: \(User.id)")
                    UserDefaults.standard.set(true, forKey: "isAuth")
                    UserDefaults.standard.synchronize()
                    self.alertSuccess()
                    
                }
    }
    }
    // MARK: Alert
    func alertFail(with contentAlert: String){
           let alert = UIAlertController(title: "Đăng ký thất bại", message: contentAlert, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
          
       }
       
    func alertSuccess(){
    let alert = UIAlertController(title: "Đăng ký thành công", message: "", preferredStyle: .alert)
        present(alert, animated: true, completion: nil)
        let when = DispatchTime.now() + 0.5
        DispatchQueue.main.asyncAfter(deadline: when) {
            alert.dismiss(animated: true) {
                if let mydDelegate = UIApplication.shared.delegate as? AppDelegate {
                    mydDelegate.navigate(K.ScreenName.TabBarController)
                }
            }
        }
    }
}
