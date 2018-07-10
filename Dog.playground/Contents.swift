//: Playground - noun: a place where people can play

import Foundation


struct Resource<T> {
    let url: URL
    let parse : (Data) -> T
}


enum Gender {
    case male, female
}

extension Gender: Equatable {
    static func ==(_ lhs: Gender, _ rhs: Gender) -> Bool {
        switch (lhs, rhs) {
        case (.male, .male): return true
        case (.female, .female): return true
        case (.female, .male): return false
        case (.male, .female): return false
        }
    }
}

struct Human {
    let name: String
    let age: Int
    let gender : Gender
}

extension Human: Equatable {
    static func ==(_ lhs: Human, _ rhs: Human) -> Bool {
        let nameCheck = lhs.name == rhs.name
        let ageCheck = lhs.age == rhs.age
        let genderCheck = lhs.gender == rhs.gender
        return nameCheck && ageCheck && genderCheck
    }
}


let chris = Human(name: "Chris", age: 22, gender: .male)
let chris2 = Human(name: "Chris", age: 22, gender: .male)


let kiiru = Human(name: "Kiiru", age: 18, gender: .male)
let ngatia = Human(name: "Ngatia", age: 22, gender: .male)
let jessica = Human(name: "Jessica", age: 45, gender: .female)
let maryam = Human(name: "Maryam", age: 67, gender: .female)

let humans = [kiiru, ngatia, jessica, maryam]


let females = humans.filter { human in
    return human.gender == .female
}

let adults = humans.filter { human in
    return human.age >= 18
}

let youngins = humans.filter { human in
    return human.age <= 18
}





















enum Form {
    case spider, human
}

extension Form {
    var toggle: Form {
        switch self {
        case .spider:
            return .human
        case .human:
            return .spider
        }
    }
}

struct Elise {
    var form : Form
}


extension Elise {
    mutating func transform() {
        switch form {
        case .human:
            form = .spider
        case .spider:
            form = .human
        }
    }
}

extension Elise {
    func chat() {
        switch form {
        case .human:
            print("Being a human is so much fun, I look great for a Century old Spider Queen")
        case .spider:
            print("Ahhh My spider form, I feel so at home, I love having 8 legssss")
        }
    }
}



var elise = Elise(form: .human)

elise.transform()



elise.transform()



elise.transform()





//elise.chat()




elise.transform()

elise.chat()




















