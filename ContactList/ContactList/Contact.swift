
class Contact {
    
    static var shared = [Contact]()
    
    init() {}
    init(name: String?, surname: String?, number: String?) {
        self.name = name
        self.surname = surname
        self.number = number
    }
    
    var name: String?
    var surname: String?
    var number: String?
}
