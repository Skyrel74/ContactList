
class Contact {
    
    static var shared = [Contact]()
    
    var name: String
    var surname: String?
    var number: String
    
    // MARK: - Initialization
    
    init(name: String, surname: String?, number: String) {
        self.name = name
        self.surname = surname
        self.number = number
    }
    
    
}
