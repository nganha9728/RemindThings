//
//  Indicator.swift
//  ECBSE
//
//  Created by Editor on 07/12/19.
//  Copyright © 2019 Pawandeep Singh. All rights reserved.
//

import Foundation
import UIKit

 var containerView = UIView()

 var progressView = UIView()

fileprivate var aView : UIView?

//let ai = UIActivityIndicatorView(style: .whiteLarge)
let ai = UIActivityIndicatorView(style: .whiteLarge)

extension UIViewController {
    
    func ShowActivityIndicator(){
        
        containerView.frame = view.frame
        containerView.frame.origin = CGPoint(x: 0, y: 0)
        containerView.backgroundColor = UIColor.white
        
        progressView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        progressView.center = containerView.center//view.center
        progressView.backgroundColor = UIColor(red: 64/255, green: 150/255, blue: 238/255, alpha: 0.7)
        progressView.clipsToBounds = true
        progressView.layer.cornerRadius = 10
        aView = UIView(frame: self.view.bounds)
        aView?.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        
        ai.center = CGPoint(x: progressView.bounds.width / 2, y: progressView.bounds.height / 2)
        progressView.addSubview(ai)
        containerView.addSubview(progressView)
        view.addSubview(containerView)
        ai.startAnimating()
    }
    
    func hideActivityIndicator(){
        ai.stopAnimating()
        containerView.removeFromSuperview()
        aView = nil
    }
    
}

