//
//  CustomProgressBar.swift
//  RemindThings
//
//  Created by NganHa on 4/27/20.
//  Copyright © 2020 Galaxy. All rights reserved.
//

import UIKit

class CustomProgressBar: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
  
     var progressLayer = CAShapeLayer()
     var trackLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var progressColor = UIColor.white{
        didSet{
            progressLayer.strokeColor = progressColor.cgColor
            
        }
    }
    var trackColor = UIColor.white{
           didSet{
               trackLayer.strokeColor = trackColor.cgColor
               
           }
       }
     func createCircularPath(progressLayerNum : Float){
        self.backgroundColor = UIColor.clear
        self.layer.cornerRadius  = self.frame.size.width/2
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width/2, y: frame.size.height/2), radius: (frame.size.width - 1.5)/2 , startAngle: CGFloat(-0.5 * .pi), endAngle: CGFloat(1.5 * .pi), clockwise: true)
        trackLayer.path = circlePath.cgPath
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.strokeColor = trackColor.cgColor
        trackLayer.lineWidth = 3.0
        trackLayer.strokeEnd = 1.0
        layer.addSublayer(trackLayer)
        
        progressLayer.path = circlePath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = progressColor.cgColor
        progressLayer.lineWidth = 3.0
        progressLayer.strokeEnd = CGFloat(progressLayerNum)
        layer.addSublayer(progressLayer)
    }
    

}
