//: Playground - noun: a place where people can play

import Foundation




print("Hello World")


let numbers = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]

let numbers1 = [1,2,3]
let numbers2 = [4,5,6]

let numbers3 = numbers1 + numbers2

print(numbers3)



let mirror = Mirror(reflecting: numbers)
print(mirror)



extension Sequence {
    func last(where predicate: (Element) -> Bool) -> Element? {
        for element in reversed() where predicate(element) {
            return element
        }
        return nil
    }
}


extension Array {
    func accumulate<Result>( _ initialResult: Result, _ nextPartialResult: (Result, Element) -> Result) -> [Result] {
        var running = initialResult
        return map { next in
            running = nextPartialResult(running, next)
            return running
        }
    }
}

extension Array {
    func filterOut(_ predicate: (Element) -> Bool) -> [Element] {
        var result = [Element]()
        for x in self where predicate(x) {
            result.append(x)
        }
        return result
    }
}


extension Array {
    func map2<T>(_ predicate: (Element) -> T) -> [T] {
        return reduce([]){
            $0 + [predicate($1)]
        }
    }
}


enum myOptional<Wrapped> {
    case none
    case some(Wrapped)
}

extension Optional {
    func unwrap(hint hintExpression: @autoclosure () -> String? = nil, file: StaticString = #file, line: UInt = #line) -> Wrapped {
        guard let unwrapped = self else {
            var message = "Required value was nil in \(file), at line \(line)"
            
            if let hint = hintExpression() {
                message.append(". Debbuging hint: \(hint)")
            }
            preconditionFailure(message)
        }
        return unwrapped
    }
}

var isDebug = false

func assert(_ expression: @autoclosure () -> Bool,
            _ message: @autoclosure () -> String) {
    guard isDebug else {
        return
    }
    
    if !expression() {
        assertionFailure(message())
    }
}




let element = numbers.last { $0 % 2 == 0 }
let accumulate = numbers.accumulate(0, +)
print(accumulate)
