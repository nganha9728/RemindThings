//
//  TabBarControllerViewController.swift
//  RemindThings
//
//  Created by NganHa on 4/24/20.
//  Copyright © 2020 Galaxy. All rights reserved.
//

import UIKit

class TabBarControllerViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //have to do this method, unless the navbar will show under
        navigationController?.navigationBar.isHidden = true
        // Do any additional setup after loading the view.
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
