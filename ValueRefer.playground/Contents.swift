//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

class Dog {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

struct Human {
    var name: String
}


let kunta = Dog(name: "Kunta")
let newPet = kunta
newPet.name = "NewName"

print(kunta.name)

let human = Human(name: "Grace")
var newHuman = human
newHuman.name = "Chris"

print(human.name)
