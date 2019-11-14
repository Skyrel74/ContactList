//
//  CreateContactVC.swift
//  ContactList
//
//  Created by Ilya on 09.11.2019.
//  Copyright © 2019 Ilya. All rights reserved.
//

import UIKit

class CreateContactVC: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var surnameField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidDisappear(_ animated: Bool) {
        errorLabel.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.phoneField.delegate = self
    }
    
    @IBAction func saveContact(_ sender: Any) {
        if (nameField.text != "" && phoneField.text != "") {
            if (phoneField.text?.count != 11) {
                errorLabel.text = "Phone nuber should contain 11 numbers"
            } else {
                let newContact = Contact(
                    name: nameField.text as! String,
                    surname: surnameField.text,
                    number: phoneField!.text as! String
                )
                Contact.shared.append(newContact)
                
                self.navigationController?.popViewController(animated: true)
            }
        }
        else {
            errorLabel.text = "You can not make new contact without name and phone number\nPlease fill these fields"
        }
    }

}

extension CreateContactVC: UITextFieldDelegate {    //Phone text field now only for numbers
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharecters = CharacterSet.decimalDigits
        let charecterSet = CharacterSet(charactersIn: string)
        return allowedCharecters.isSuperset(of: charecterSet)
    }
}
