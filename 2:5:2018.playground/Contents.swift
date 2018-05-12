//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

extension Array {
    func chrisMap<T>(_ transform: (Element) throws -> T) rethrows -> [T] {
        var result = [T]()
        for x in self {
            result.append(try transform(x))
        }
        return result
    }
}

func multiplyPositive<T: Numeric>(_ lhs: T, _ rhs: T) -> T {
    return lhs * rhs
}

extension Sequence where Element: Numeric {
    func multiPly() -> Element {
        return reduce(1, *)
    }
}

let evenNumbers = [2,4,6,8,10]

evenNumbers.multiPly()


multiplyPositive(5, 5)



evenNumbers.chrisMap{
    return $0 * $0
}

let x = evenNumbers as NSArray
x[1] is NSNumber

let dict = ["Family": ["Chris", "Kiannah", "Carlton", "Dad", "Mom"],
            "Friends": ["Kiiru", "Nduati", "Kayima", "Vanessa"]]

//print(dict["Family"])




var arr = [1,2,3,4,5]

arr.map { (number) -> Int in
    var array = [Int]()
    array.append(number)
    return number
}





