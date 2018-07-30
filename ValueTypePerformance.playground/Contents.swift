 //: Playground - noun: a place where people can play

import Foundation

var str = "Hello, playground"

 
 var sampleBytes : [UInt8] = [0x0b, 0xad, 0xf0, 0x0d]

 let nsData = NSMutableData(bytes: sampleBytes, length: sampleBytes.count )
 let nsOtherData = nsData.mutableCopy() as! NSMutableData // copy must be explicit!
 
 
 // NSMutableData is a reference type, so can still be mutated even tho it is declared with let
 // In such cases, only the pointer to the referance is immutable
 nsData.append(sampleBytes, length: sampleBytes.count)
 nsOtherData // explicit copy, in order to create value semantics
 
 
 // value types. if `let` cannot mutate Data
var theData = Data(bytes: sampleBytes)
 // values are copied when assigned to another variable
 // in contrast, assigning an object to another variable just creates another reference that points to the object
 // ** struct is copied field by field
 // ** when struct is copied only the reference is copied to the new value
let copy = theData
 
// The actual data is only copied once we make changes to it
 theData.append(contentsOf: sampleBytes)
 copy
 
 struct MyData {
    var data = NSMutableData()
    var dataForWriting : NSMutableData {
        mutating get {
            data = data.copy() as! NSMutableData
            return data
        }
    }
    
    mutating func append(_ bytes: [UInt8]) {
        dataForWriting.append(bytes, length: bytes.count)
    }
 }

 extension MyData : CustomDebugStringConvertible {
    var debugDescription: String {
        return String(describing: data)
    }
 }
 
 
 var data = MyData()
 var copyCat = data
 
 //
// data.append(sampleBytes)
// copyCat
 
 
 class Box<T> {
    let item: T
    init(_ type: T) {
        self.item = type
    }
 }
 
 
 enum Gender {
    case male, female
 }
 
 extension Gender: Equatable {
    static func ==(_ lhs: Gender, _ rhs: Gender) -> Bool {
        switch (lhs, rhs) {
        case (.male, .male):
            return true
        case (.male, .female):
            return false
        case (.female, .female):
            return true
        case (.female, .male):
            return false
        }
    }
 }
 
 
 
 struct Human {
    let name: String
    let age : Int
    let gender: Gender
 }
 
 extension Human: Equatable {
    static func ==(_ lhs: Human, _ rhs: Human) -> Bool {
        let nameCheck = lhs.name == rhs.name
        let ageCheck = lhs.age == rhs.age
        let genderCheck = lhs.gender == rhs.gender
        return nameCheck && ageCheck && genderCheck
    }
 }
 
 let will2 = Human(name: "Will", age: 66, gender: .female)
 
 
 let chris = Human(name: "Chris", age: 55, gender: .male)
 let will = Human(name: "Will", age: 66, gender: .female)
 let kiiru = Human(name: "Kiiru", age: 35, gender: .male)
 let jess = Human(name: "Jess", age: 12, gender: .female)

 let humans = [chris, will, kiiru, jess]
 
//
// if will == will2 {
//    print("Equatable")
// }
 
 
 for human in humans where human.age > 18 {
    print(human.name)
 }
 


 
 
 var array = [Int](repeating: 0, count: 5)

 
 
 
 
 
