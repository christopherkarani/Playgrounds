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
 data.append(sampleBytes)
 copyCat
 
 
 
 
 
 
 
 
 
 
 
 
 
 
