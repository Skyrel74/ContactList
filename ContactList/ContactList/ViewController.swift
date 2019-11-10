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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Contact.shared.append(Contact(name: "Ilya", surname: "Rakipov", number: "89507357030"))
        Contact.shared.append(Contact(name: "Egor", surname: "Letov", number: "88005553535"))
        Contact.shared.append(Contact(name: "Kurt", surname: "Kobein", number: "89567341254"))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        contactsList.reloadData()
        if (Contact.shared.count == 0) {
            addInfo.alpha = 1.0
        }
        else {
            addInfo.alpha = 0.0
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
