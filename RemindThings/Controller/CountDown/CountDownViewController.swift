//
//  CountDownViewController.swift
//  RemindThings
//
//  Created by NganHa on 5/4/20.
//  Copyright © 2020 Galaxy. All rights reserved.
//

import UIKit

class CountDownViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{

 
    let appDel = UIApplication.shared.delegate
    var pickerData = [Int]()
    var choosen = 0
    
    @IBOutlet weak var nameActionText: UITextField!
  
    @IBOutlet weak var pickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.dataSource = self
        pickerView.delegate = self
        getPickerData()
        // tap keyboard
        initializeHideKeyboard()
        //notification
        // Assing self delegate on userNotificationCenter
        
         
       
    }
  
    override func viewWillAppear(_ animated: Bool) {
        nameActionText.text = nil
        
    }
//MARK: picker
 func numberOfComponents(in pickerView: UIPickerView) -> Int {
     return 1
 }
 
 func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
     return pickerData.count
 }
 func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
     return "\(pickerData[row])"
 }
 
 func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
     choosen = pickerData[row]
   
 }

    func getPickerData(){
        for i in 1...120{
            pickerData.append(i)
            
        }
    }
    
     @IBAction func startPressed(_ sender: UIButton) {
        if nameActionText.text  == nil {
            let alert = UIAlertController(title: "Vui lòng nhập hành động", message: "Bạn phải nhập hành động trước khi tiến hành đếm giờ", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
       else {
        performSegue(withIdentifier: K.Segue.detailCountDown, sender: self)
        }
       
        
     }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(choosen)
         let desVC = segue.destination as! DetailCountDownViewController
        if choosen == 0 {
            desVC.totalTime = 1
        }
        else {
            desVC.totalTime = choosen
        }
        desVC.actionName  = nameActionText.text!
        
     }


    
}

