//
//  TableCell.swift
//  ContactList
//
//  Created by Ilya on 09.11.2019.
//  Copyright © 2019 Ilya. All rights reserved.
//

import UIKit

class TableCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var surnameLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    
    func setup(name: String, surname: String?, number: String) {
        nameLabel.text = name
        surnameLabel.text = surname
        numberLabel.text = number
    }
}
