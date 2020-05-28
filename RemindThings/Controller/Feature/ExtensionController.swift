//
//  ExtensionController.swift
//  RemindThings
//
//  Created by NganHa on 4/19/20.
//  Copyright © 2020 Galaxy. All rights reserved.
//

import UIKit

// MARK: setIcon for TextField
extension UITextField{

    func setIcon(_ image: UIImage) {
          let iconView = UIImageView(frame:
                         CGRect(x: 10, y: 5, width: 20, height: 20))
          iconView.image = image
          let iconContainerView: UIView = UIView(frame:
                         CGRect(x: 20, y: 0, width: 30, height: 30))
          iconContainerView.addSubview(iconView)
        leftView = iconContainerView
       leftViewMode = .always
       }
    
    }
//MARK: handle keyboard

extension UIViewController{
    
    // Via Tap Gesture
    //
    //
    
    func initializeHideKeyboard(){
    //Declare a Tap Gesture Recognizer which will trigger our dismissMyKeyboard() function
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(
    target: self,
    action: #selector(dismissMyKeyboard))

    //Add this tap gesture recognizer to the parent view
    view.addGestureRecognizer(tap)
    }

    @objc func dismissMyKeyboard(){
    //endEditing causes the view (or one of its embedded text fields) to resign the first responder status.
    //In short- Dismiss the active keyboard.
    view.endEditing(true)
    }
    
}




