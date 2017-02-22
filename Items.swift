//
//  Items.swift
//  Simple Shopping List
//
//  Created by Luis Esquivel on 2017-02-21.
//  ID 300869199
//  Purpose: Handle data model for Shopping List
//  Copyright © 2017 luis. All rights reserved.
//

import UIKit
import Firebase

class Items {
    // MARK: Properties
    
    var itemName: String
    var itemQtty: Int
    
    let key: String
    let ref: FIRDatabaseReference?
    
    
    // MARK: Initialization
    
    init?(itemName: String,
          itemQtty: Int, key: String = "") {
        
        // Initialize stored properties.
        self.key = key
        self.itemName = itemName
        self.itemQtty = itemQtty

        self.ref = nil
        
        // Initialization should fail if there is no "item" name.
        if itemName.isEmpty {
            
            return nil
            
        }
        
    }

    init(snapshot: FIRDataSnapshot) {
        key = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
        itemName = snapshotValue["itemName"] as! String
        itemQtty = snapshotValue["itemQtty"] as! Int
        ref = snapshot.ref
    }
    
    func toAnyObject() -> Any {
        return [
            "itemName": itemName,
            "itemQtty": itemQtty
        ]
    }

}
