//
//  ItemTableViewController.swift
//  RemindThings
//
//  Created by NganHa on 5/3/20.
//  Copyright © 2020 Galaxy. All rights reserved.
//

import UIKit
import Firebase
import ChameleonFramework
import SwipeCellKit
class ItemTableViewController: UITableViewController, SwipeTableViewCellDelegate {
    let db = Firestore.firestore()
    var listItem = Array<Item>()
    var category: Categogy?{
        didSet{
            loadItems()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80.0
    }
    override func viewWillAppear(_ animated: Bool) {
        let nav = UINavigationController()
        nav.navigationBar.backgroundColor = UIColor.init(hexString: category!.color)
        
    }

    // MARK: FIREBASE
    func loadItems(){
        listItem.removeAll()
        self.ShowActivityIndicator()
        let getItems = db.collection("user").document(User.id).collection("category").document(category!.id).collection("item")
        getItems.order(by: "date", descending: true).getDocuments() { (querySnapshot, error) in
            if let e = error{
                print("Have some error in \(e)")
                }
            else {
                self.hideActivityIndicator()
                for document in querySnapshot!.documents {
                   let doc = document.data()
                    let id = document.documentID
                    if let nameItem = doc["name"], let doneItem = doc["done"], let dateItem = doc["date"]{
                        
                       let newName = nameItem as! String
                        let newDone = doneItem as! Bool
                        let newDate = dateItem as! Timestamp
                        let newItem = Item(id: id, name: newName, date: newDate, done: newDone)
                       self.listItem.append(newItem)
                    }
                }
                self.tableView.reloadData()
            }
        }
        
        }
    //MARK: Table resource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return self.listItem.count
        
}
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: K.TableCell.ItemCell, for: indexPath) as! SwipeTableViewCell

            let item = listItem[indexPath.row]
            cell.textLabel?.text = item.name
            let color = UIColor(hexString: category!.color)?.darken(byPercentage: CGFloat(indexPath.row) / CGFloat (listItem.count))
            cell.backgroundColor = color
            cell.textLabel?.textColor = ContrastColorOf(color!, returnFlat: true)
            cell.tintColor = ContrastColorOf(color!, returnFlat: true)
                
            cell.accessoryType = item.done ? .checkmark : .none
            
        cell.delegate = self
        return cell
    }
    
    //MARK: table delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if listItem.count >= 1{
            let item = listItem[indexPath.row]
            var check = false
            if item.done{
                check = false
            } else {check = true}
            
            let changeItem = db.collection("user").document(User.id).collection("category").document(category!.id).collection("item").document(item.id)
            changeItem.updateData(["done" : check as Any]) { (error) in
                if let e = error {
                    print("LOI \(e)")
                }
                else {
                    print(item.id)
                    print(self.listItem)
                    self.listItem[indexPath.row].done = check
                    
                    self.loadItems()
                }
            }
        }
    }
      // MARK: Swipe Delegate
        func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
            guard orientation == .right else {
                return nil
            }
            let deleteAction = SwipeAction(style: .default, title: "Delete") { (action, indexPath) in
              
                let id = self.listItem[indexPath.row].id
                self.listItem.remove(at: indexPath.row)
                self.deleteCell(at: id)
    //            self.tableView.reloadData()
               
            }
            deleteAction.image = UIImage(named: "delete")
            
            return [deleteAction]
           }
        func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
            var options = SwipeOptions()
            options.expansionStyle = .destructive
            options.transitionStyle = .border
            return options
        }
    
    //MARK: delete swipe cell
    func deleteCell(at idItem: String) {
        db.collection("user").document(User.id).collection("category").document(category!.id).collection("item").document(idItem).delete { (error) in
            if let e = error {
                print("\(e)")
            }
            else{
                print("hihi")
                self.loadItems()
            }
        }
    }
    //MARK: Add Button
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController.init(title: "Thêm mới chi tiết công việc", message: "", preferredStyle: .alert)
              var text =  UITextField()
              let action = UIAlertAction.init(title: "Thêm", style: .default) { (action) in
                  
                var newItem = Item(id: "", name: text.text!, date: Timestamp(), done: false)
                  
                  var ref: DocumentReference? = nil
                ref = self.db.collection("user").document(User.id).collection("category").document(self.category!.id).collection("item")
                    .addDocument(data: [
                      "name": newItem.name,
                      "date": newItem.date,
                      "done": newItem.done
                         ]) { (error) in
                             if let e = error{
                                 print("error with saving new thing : \(e)")
                             } else {
                              newItem.id = ref?.documentID as! String
                               self.listItem.append(newItem)
                              self.tableView.reloadData()
                          }
                         }
              }
                  
                  alert.addTextField { (textfield) in
                      textfield.placeholder = "Nhập chi tiết công việc"
                      text = textfield
              }
                  alert.addAction(action)
                  present(alert, animated: true, completion: nil)
        
    }
    
  
    
    

   

}
