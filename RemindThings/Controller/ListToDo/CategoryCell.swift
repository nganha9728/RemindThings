//
//  CategoryCell.swift
//  RemindThings
//
//  Created by NganHa on 4/25/20.
//  Copyright © 2020 Galaxy. All rights reserved.
//

import UIKit
import SwipeCellKit
class CategoryCell: SwipeTableViewCell {

   
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var view: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }
    func createProgressBar(with progress: Float, color: UIColor){
    let progressBarView = CustomProgressBar(frame: CGRect(x: 0, y: 0, width: 50.0, height: 50.0))
    progressBarView.progressLayer.strokeEnd = CGFloat(progress)
    let trokeEnd = progressBarView.progressLayer.strokeEnd
    progressBarView.createCircularPath(progressLayerNum: Float(trokeEnd))
    progressBarView.trackColor = UIColor.lightGray
    progressBarView.progressColor = color
    view.addSubview(progressBarView)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    
    
}
