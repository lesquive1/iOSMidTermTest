//
//  ItemsTableViewCell.swift
//  Simple Shopping List
//
//  Created by Luis Esquivel on 2017-02-21.
//  ID 300869199
//  Purpose: This class allows to handle the Cell on the TableView for the Shopping List
//  Copyright © 2017 luis. All rights reserved.
//

import UIKit

class ItemsTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var itemNameText: UITextField!
    @IBOutlet weak var itemQttyLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // This function allows user to change quantitys on the shopping list items
    @IBAction func itemStepperAction(_ sender: UIStepper) {
        itemQttyLabel.text = "\(Int(sender.value))"
    }
}
