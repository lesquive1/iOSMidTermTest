//
//  ViewController.swift
//  Simple Shopping List
//
//  Created by Luis Esquivel on 2017-02-21.
//  ID 300869199
//  Copyright © 2017 luis. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ViewController: UIViewController, UITableViewDataSource {

    var items = [Items]()
    let ref = FIRDatabase.database().reference()
    
    @IBOutlet weak var tableShoppingItems: UITableView!
    @IBOutlet weak var listName: UITextField!

    
    var tagIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Use the edit button item provided by the table view controller.
        //navigationItem.leftBarButtonItem = editButtonItem
        navigationItem.backBarButtonItem = editButtonItem
        
        // reading data from firebase
        ref.observe(.value, with: { snapshot in
            
            var newItems: [Items] = []
            
            for item in snapshot.children {
                
                let item = Items(snapshot: item as! FIRDataSnapshot)
                newItems.append(item)
            }
            
            self.items = newItems
            //self.tableView.reloadData()
            self.tableShoppingItems.reloadData()
            
        })
        
        //loadTasks()
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

        let  cellIdentifier = "itemCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ItemsTableViewCell
        
        let item = items[indexPath.row]
        cell.itemNameText.text = item.itemName
        cell.itemQttyLabel.text = "\(item.itemQtty)"
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    // support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    // This function populate the Items model with sample/initial data
    func loadTasks() {
        
        let item1 = Items(itemName: "Item 1", itemQtty: 0)!
        let item2 = Items(itemName: "Item 2", itemQtty: 0)!
        let item3 = Items(itemName: "Item 3", itemQtty: 0)!
        let item4 = Items(itemName: "Item 4", itemQtty: 0)!
        let item5 = Items(itemName: "Item 5", itemQtty: 0)!

        
        items += [item1, item2, item3, item4, item5]
        
    }

    // When cancel button is pressed the values of the shopping list change to default values
    @IBAction func itemsCancel(_ sender: UIBarButtonItem) {
        tableShoppingItems.reloadData()
        listName.text = "Shopping List"
    }
    
    @IBAction func saveShoppingList(_ sender: UIBarButtonItem) {
        let itemRef = self.ref.child(listName.text!)
        let item1 = Items(itemName: "Item 1", itemQtty: 0)!
        itemRef.setValue(item1.toAnyObject())
    }
    
    // MARK: Add Item
    
    @IBAction func addButtonDidTouch(_ sender: AnyObject) {
        let alert = UIAlertController(title: "Shopping List",
                                      message: "Add an Item",
                                      preferredStyle: .alert)
        
        
        let saveAction = UIAlertAction(title: "Save",
                                       style: .default) { _ in
                                    
                                        guard let textField = alert.textFields?.first,
                                            let text = textField.text else { return }
                                        
                                        
                                        let item = Items(itemName: text, itemQtty: 0)

                                        let itemRef = self.ref.child((item?.itemName.lowercased())!)

                                        itemRef.setValue(item?.toAnyObject())
        }
        
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default)
        
        alert.addTextField()
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    
}

