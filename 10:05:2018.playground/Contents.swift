//: Playground - noun: a place where people can play

import Foundation

var str = "Hello, playground"


// Set an unordered Collection of elements, which each elemnt appearing only once
// you can think of a set as a dictionaru that only stores keys and no values

func sum(_ x: Int, _ y: Int) -> Int {
    return x + y
}


let values = [5,10,15,20]

let sumOfValues = values.reduce(0, sum)

var indicies = IndexSet()

let closedRange = 1...10

let nonClosedRange = 1..<10


indicies.insert(integersIn: 1...10)


extension Sequence where Element: Hashable {
    func unique() -> [Element] {
        var seen: Set<Element> = []
        return filter { element in
            if seen.contains(element) {
                return false
            } else {
                seen.insert(element)
                return true
            }
        }
    }
}

let singleDigitNumbers = 0..<10


enum Gender {
    case male, female
}

extension Gender {
    static func ==(lhs: Gender, rhs: Gender) -> Bool {
        switch (lhs, rhs) {
        case (.female, .male):
            return false
        case (.female, .female):
            return true
        case (.male, .female):
            return false
        case (.male, .male):
            return true
        }
    }
}

extension Gender: CustomStringConvertible {
    var description: String {
        switch self {
        case .male:
            return "Male"
        case .female:
            return "Female"
        }
    }
}

protocol NameIdentifiable {
    var name : String { get }
}

struct Human: NameIdentifiable {
    let name: String
    let gender : Gender
    var age: Int
    var credentials : (name: String, gender: Gender, age: Int) {
        return (name, gender, age)
    }
}

func take<C:Collection>(_ value: C) where C.Iterator.Element ==  NameIdentifiable {
    print(value.first?.name ?? "")
}

let humans = [Human(name: "Kiiru", gender: .male, age: 19), Human(name: "Chris", gender: .male, age: 22), Human(name: "Carol", gender: .female, age: 33), Human(name: "Meg", gender: .female, age: 44)]
for human in humans {
    print(human.credentials)
}

extension Human: Equatable {
    static func ==(_ lhs: Human, _ rhs: Human) -> Bool {
        return (lhs.name == rhs.name) && (lhs.gender == rhs.gender)
    }
}

let r = 5...
r.contains(2)

let d = 5..<5

