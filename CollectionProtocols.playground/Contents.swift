//: Playground - noun: a place where people can play

import Foundation

var str = "Hello, playground"

// recursive
func fib(_ n: Int) -> Int {
    guard n > 2 else { return n }
    return fib(n-1) + fib(n-2)
}


let result = fib(6)

struct FibsIterator: IteratorProtocol {
    var state = (0,1)
    mutating func next() -> Int? {
        guard state.0 <= 4000000 else { return nil }
        let upcomingNumber = state.0
        state = (state.1, state.0 + state.1)
        return upcomingNumber
    }
}

var iterator = FibsIterator()

// create fibonacci collection
struct Fibonacci : Sequence {
    func makeIterator() -> FibsIterator {
        return FibsIterator()
    }
}

let fibs = Fibonacci()

for n in fibs {
    if n < 4000000 {
        print(n)
    }
}








//for val in fibs where val % 2 == 0 {
//    sum += val
//}
let stdIn = AnySequence {
    return AnyIterator {
        readLine()
    }
}

let numberedStdIn = stdIn.enumerated()
for (i, line) in numberedStdIn {
    print("\(i+1):\(line)")
}


protocol XSequence {
    associatedtype Element
    associatedtype iterator: IteratorProtocol where iterator.Element == Element
    associatedtype SubSequence
}

struct User: ExpressibleByStringLiteral {
    
    var name: String

    init(stringLiteral value: String) {
        name = value
    }
}

let chris: User = "Chris"









//chris.name


enum List<Element> {
    case end
    // the indirect keyword here indicates that the compiler should represent the node value as a reference
    indirect case node(Element, next: List<Element>)
}

extension List {
    /// return a new list by prepending a node with value 'x' to the
    /// front of the list
    func cons(_ x: Element) -> List {
        return .node(x, next: self)
    }
}

extension List: ExpressibleByArrayLiteral {
    init(arrayLiteral elements: Element...) {
        self = elements.reversed().reduce(.end) { partialList, element in
            partialList.cons(element)
        }
    }
}

extension List {
    mutating func push(_ x: Element) {
        self = self.cons(x)
    }
    
    mutating func pop() -> Element? {
        switch self {
        case .end: return nil
        case let .node(x, next: tail):
            self = tail
            return x
        }
    }
}

extension List: IteratorProtocol, Sequence {
    mutating func next() -> Element? {
        return pop()
    }
}


let list2: List = [3,2,1]





var stack: List<Int> = [3,2,1]
var a = stack
var b = stack

a.pop()
a.pop()
a.pop()
a.pop()
a.push(34)
a.pop()

















