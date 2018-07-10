//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

struct Person {
    struct Credentials {
        let name: String
        let surname: String
    }
    
    enum Gender {
        case male, female
    }
    
    enum Phone {
        case iphone, samsung
    }

    var credentials: Credentials
    var gender: Gender
    var phone: Phone
}

extension Person: CustomStringConvertible {
    var description: String {
        return "
    }
}


let chris = Person(credentials: .init(name: "Chris", surname: "Karani"), gender: .male, phone: .iphone)


