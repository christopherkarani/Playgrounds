//: Playground - noun: a place where people can play

import Foundation

var str = "Hello, playground"


extension Array {
    func graceMap<T>(_ t: (Element) -> T) -> [T] {
        var result = [T]()
        for element in self {
            result.append(t(element))
        }
        return result
    }
}

let arr = [1,2,3,4,5,6]
arr.graceMap { number in
    return number * number
}
