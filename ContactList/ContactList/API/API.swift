//
//  API.swift
//  ContactList
//
//  Created by Ilya on 16.11.2019.
//  Copyright © 2019 Ilya. All rights reserved.
//

import Foundation

typealias JSON = [String : Any]

enum API {
    
    static var identifier: String { return "Artorias" }
    
    static var baseURL: String {
        return "https://ios-napoleonit.firebaseio.com/data/\(identifier)/"
    }
    
    static var contacts_: String { return "contacts" }
    
    static func loadContacts(completion: @escaping ([Contact]) -> Void) {
        let url = URL(string: baseURL + ".json")!
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard
                let data = data,
                let json = try? JSONSerialization.jsonObject(with: data, options: []) as! JSON
                else { return }
            
            let contactsJSON = json[contacts_] as! JSON
            var contacts = [Contact]()
            
            for contact in contactsJSON {
                contacts.append(Contact(id: contact.key, data: contact.value as! JSON))
            }
            
            contacts.sort { $0.name < $1.name }
            
            DispatchQueue.main.async {
                completion(contacts)
            }
        }
        task.resume()
    }
    
    static func createContact(name: String, surname: String?, number: String, completion: @escaping (Bool) -> Void) {
        let params = [
            "name": name,
            "surname": surname,
            "number": number
        ]
        
        let url = URL(string: baseURL + "/\(contacts_).json")!
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: params)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            completion(error == nil)
        }
        task.resume()
    }
    
    static func editContact(contactID: String, name: String, surname: String?, number: String, completion: @escaping (Bool) -> Void) {
        let params = [
            "name": name,
            "surname": surname,
            "number": number
        ]
        
        let url = URL(string: baseURL + "/\(contacts_)/\(contactID)/.json")!
        var request = URLRequest(url: url)
        
        request.httpMethod = "PATCH"
        request.httpBody = try? JSONSerialization.data(withJSONObject: params)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            completion(error == nil)
        }
        task.resume()
    }
    
    static func deleteContact(contactID: String, completion: @escaping (Bool) -> Void) {
        let url = URL(string: baseURL + "/\(contacts_)/\(contactID)/.json")!
        var request = URLRequest(url: url)
        
        request.httpMethod = "DELETE"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            completion(error == nil)
        }
        task.resume()
    }
}
