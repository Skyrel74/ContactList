//
//  ContactCell.swift
//  ContactList
//
//  Created by Ilya on 09.11.2019.
//  Copyright © 2019 Ilya. All rights reserved.
//

import UIKit

class ContactCell: UITableViewCell {
    
    @IBOutlet weak var contactName: UILabel!
    @IBOutlet weak var contactSurname: UILabel!
    
    func setup(_ contact: Contact){
        contactName.text = contact.name
        if contact.surname == nil {
            contactSurname.text = ""
        }
        else {
            contactSurname.text = contact.surname
        }
    }
}
