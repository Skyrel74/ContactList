
class Contact {
    
    static var shared = [Contact]()
    
    init(name: String?, surname: String?, number: String?) {
        self.name = name
        self.surname = surname
        self.number = number
    }
    
//    Comment: Лучше не делать у контакта все поля optional,
//    потому что тогда мы сможем создать контакт вообще без данных.
//    Если пользователь ничего не ввёл, лучше обрабатывать эту
//    ситуацию и показывать пользователю ошибку сохранения
    
    var name: String?
    var surname: String?
    var number: String?
}

// А класс лучше было бы оформить вот так:

class RefactoredContact {
    
    static var shared = [Contact]()
    
//    Все свойства переносим наверх
    var name: String?
    var surname: String?
    var number: String?
    
//    А дальше делаем конструктор и выделаем его с помощью MARK
    
    // MARK: - Initialization.
    
    init(name: String?, surname: String?, number: String?) {
        self.name = name
        self.surname = surname
        self.number = number
    }
    
}
