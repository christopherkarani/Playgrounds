 //: Playground - noun: a place where people can play

import Foundation

var str = "Hello, playground"

 
 var sampleBytes : [UInt8] = [0x0b, 0xad, 0xf0, 0x0d]
 
 
 
 var nsData = NSMutableData(bytes: sampleBytes, length: sampleBytes.count )
let nsOtherData = nsData.mutableCopy() as! NSMutableData
 nsData.append(sampleBytes, length: sampleBytes.count)
 
 
var data = Data(bytes: sampleBytes)
 
 
