//
//  DetailCountDownViewController.swift
//  RemindThings
//
//  Created by NganHa on 5/6/20.
//  Copyright © 2020 Galaxy. All rights reserved.
//

import UIKit

class DetailCountDownViewController: UIViewController {
    
    @IBOutlet weak var secondText: UILabel!
    @IBOutlet weak var minutesText: UILabel!
    @IBOutlet weak var nameAction: UILabel!
    @IBOutlet weak var progress: UIProgressView!
    var totalTime  = 0
    var min = 0
    var sec = 0
    var secondPassed = 0
    var newTime = 0
    var newSecondPassed = 0
    var timer = Timer()
    var actionName = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        countDown()
   
    }
    override func viewWillAppear(_ animated: Bool) {
        progress.progress = 0.0
        secondText.text = "0"
        minutesText.text = "0"
    }
    override func viewWillDisappear(_ animated: Bool) {
        timer.invalidate()
         newTime = secondPassed
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimeWhenViewDisappear), userInfo: nil, repeats: true)
    }
    @objc func updateTimeWhenViewDisappear(){
        if newSecondPassed < newTime {
            newSecondPassed += 1
        }
        else {
            timer.invalidate()
            pushNotification()
        }
    }
    func pushNotification(){
          let content = UNMutableNotificationContent()
          content.title = "Title"
          content.body = "Body"
              content.sound = UNNotificationSound.default

          let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
          let request = UNNotificationRequest(identifier: "TestIdentifier", content: content, trigger: trigger)
          UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
          }
    
    
    @IBAction func cancelPressed(_ sender: UIButton) {
        let alert  = UIAlertController(title: "Bạn có muốn huỷ hành động \(actionName) không?", message: "Hãy cố gắng để hoàn thành mục tiêu", preferredStyle: .alert)
           let actionOK = UIAlertAction(title: "Có", style: .default) { (action) in
            // come back the CountDownVC by pop ViewController
            // ViewControllers in stack [HomeVC; CountDownVC; DetailCountDownVC] => by use pushing (segue);
            // we create a stack of VC
            self.navigationController?.popViewController(animated: true)
           }
        let actionCancel = UIAlertAction(title: "Không", style: .default, handler: nil)
            
           alert.addAction(actionOK)
        alert.addAction(actionCancel)
           present(alert, animated: true, completion: nil)
    }
    @IBAction func donePressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "Bạn đã thực hiện xong \(actionName) ?", message: "Chúc mừng bạn đã hoàn thành trước thời hạn", preferredStyle: .alert)
        let action = UIAlertAction(title: "Đồng ý", style: .default) { (action) in
              // come back the CountDownVC by pop ViewController
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    func countDown(){
        nameAction.text = "Để thực hiện \(actionName)"
        min = totalTime
        sec = totalTime * 60
        timer.invalidate()
        Timer.scheduledTimer(timeInterval: 1.00, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    
    }
    @objc func updateTimer(){
        if secondPassed < sec {
            progress.progress = Float (secondPassed) / Float (sec)
            let remainTime = sec - secondPassed
            let remindMin  = Int (remainTime / 60)
            let remindSec  = remainTime % 60
            secondText.text = String(remindSec)
            minutesText.text = String(remindMin)
            secondPassed += 1
        }
        else {
            minutesText.text = "0"
            progress.progress = 1.0
            timer.invalidate()
            //pushAlert()
            pushNotification()
             self.navigationController?.popViewController(animated: true)
            
        }
    }
    func pushAlert(){
        let alert  = UIAlertController(title: "Bạn đã hết giờ để làm việc", message: "Mong bạn hoàn thành mục tiêu", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
           // come back the CountDownVC by pop ViewController
            self.navigationController?.popViewController(animated: true)
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    

}

