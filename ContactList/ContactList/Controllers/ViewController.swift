//
//  ViewController.swift
//  ContactList
//
//  Created by Ilya on 09.11.2019.
//  Copyright © 2019 Ilya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var contactsList: UITableView!
    @IBOutlet weak var addInfo: UILabel!                //Label w/ info about ability to create contact
    @IBOutlet weak var loadIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadIndicator.startAnimating()
        DispatchQueue.global().async {
            API.loadContacts { contactsArray in
                Contact.shared = contactsArray
                self.contactsList.reloadData()
            }
            DispatchQueue.main.async {
                if (self.contactsList.numberOfSections == 0) {
                    self.addInfo.alpha = 1.0
                }
                else {
                    self.addInfo.alpha = 0.0
                }
                self.loadIndicator.stopAnimating()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EDSegue" {            
            if let nextViewController = segue.destination as? EditAndDeleteVC {
                let indexPath = self.contactsList.indexPathForSelectedRow
                nextViewController.indexPathRow = indexPath!.row
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Contact.shared.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell") as! TableCell
        let contact = Contact.shared[indexPath.row]
        cell.setup(name: contact.name, surname: contact.surname, number: contact.number)
        return cell
    }
}
