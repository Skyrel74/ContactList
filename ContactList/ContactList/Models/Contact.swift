
class Contact {
    
    static var shared = [Contact]()
    
    var id: String
    var name: String
    var surname: String?
    var number: String
    
    // MARK: - Initialization
    
    init(id: String, data: JSON) {
        self.id = id
        self.name = data["name"] as! String
        self.surname = data["surname"] as? String
        self.number = data["number"] as! String
    }
    
    
}
