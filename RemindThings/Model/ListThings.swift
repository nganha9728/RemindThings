//
//  ListThings.swift
//  RemindThings
//
//  Created by NganHa on 4/21/20.
//  Copyright © 2020 Galaxy. All rights reserved.
//

import Foundation
import Firebase
struct Categogy {
    var id: String
    var name: String
    var color: String
    var totalNum: Int
    var doneNum: Int
    var date: Timestamp
    var listChild: [String: Item]?
}
struct Item{
    var id: String
    var name: String
    var date: Timestamp
    var done: Bool
}
