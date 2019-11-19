//
//  EditAndDeleteController.swift
//  ContactList
//
//  Created by Ilya on 19.11.2019.
//  Copyright © 2019 Ilya. All rights reserved.
//

import UIKit

class EditAndDeleteVC: UIViewController {
    
    var indexPathRow = Int()
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var surnameField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var loadIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.phoneField.delegate = self
        
        nameField.text = Contact.shared[indexPathRow].name
        surnameField.text = Contact.shared[indexPathRow].surname
        phoneField.text = Contact.shared[indexPathRow].number
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        errorLabel.text = ""
    }
    
    @IBAction func editContact(_ sender: Any) {
        if (nameField.text != "" && phoneField.text != "") {
            if (phoneField.text?.count != 11) {
                errorLabel.text = "Phone nuber should contain 11 numbers"
            } else {
                self.loadIndicator.startAnimating()
                DispatchQueue.global().async {
                    API.editContact(
                        contactID: Contact.shared[self.indexPathRow].id,
                        name: self.nameField.text!,
                        surname: self.surnameField.text,
                        number: self.phoneField.text!)
                    { result in
                        guard result else { return }
                    }
                    DispatchQueue.main.async {
                        self.loadIndicator.stopAnimating()
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
        } else {
            errorLabel.text = "You can not have contact without name or phone number\nPlease fill these fields"
        }
    }
    
    @IBAction func deleteContact(_ sender: Any) {
        self.loadIndicator.startAnimating()
        DispatchQueue.global().async {
            API.deleteContact(contactID: Contact.shared[self.indexPathRow].id)
            { result in
                guard result else { return }
            }
            DispatchQueue.main.async {
                self.loadIndicator.stopAnimating()
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
}

extension EditAndDeleteVC: UITextFieldDelegate {    //Phone text field now only for numbers
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharecters = CharacterSet.decimalDigits
        let charecterSet = CharacterSet(charactersIn: string)
        return allowedCharecters.isSuperset(of: charecterSet)
    }
}
