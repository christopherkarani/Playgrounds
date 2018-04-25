import Foundation

extension Array {
    func accumulate<U>(initial: U, combine: (U, Element) -> U) -> [U] {
        var running = initial
        return self.map { next in
            running = combine(running, next)
            return running
        }
    }
}

extension Array {
    func combination<T>(initial: T, combine: (T, Element) -> T) -> [T] {
        var running = initial
        return self.map { next in
            running = combine(running, next)
            return running
        }
    }
}

extension Sequence {
    func allMatch(predicate: (Iterator.Element) -> Bool) -> Bool {
        return self.contains {predicate($0)}
    }
}


let fibs =  [-4, 3, -9, 0, 4, 1]

let resultNegative = fibs.filter { $0 < 0 }

let twoFloat: Float = 2
let sixFloat: Float = 6



let resultPositive = fibs.filter { $0 > 0 }
let resultZero = fibs.filter { $0 == 0 }
//print(resultNegative)
//print(resultPositive)
//print(resultZero)

extension Int {
    var asFloat : Float {
        return Float(exactly: self)!
    }
}
func divide(_ lhs: Float, _ rhs: Float) -> Float {
    return lhs / rhs
}
func printResult(of arrayCount: Float, dividedBy number: Float) {
     print(divide(arrayCount, number))
}
func plusMins(_ arr: [Int]) {
    let arrayCount = arr.count.asFloat
    let resultNegative = (fibs.filter { $0 < 0 }).count.asFloat
    let resultPositive = (arr.filter { $0 > 0 }).count.asFloat
    let resultZero = (arr.filter { $0 == 0 }).count.asFloat
    
    
    
    printResult(of: resultPositive, dividedBy: arrayCount)
    printResult(of: resultNegative, dividedBy: arrayCount)
    printResult(of: resultZero, dividedBy: arrayCount)
}

plusMins(fibs)
printResult(of: 2, dividedBy: 6)
















