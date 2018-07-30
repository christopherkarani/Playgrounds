//: Playground - noun: a place where people can play

import Foundation

var str = "Hello, playground"


struct ConstantIterator: IteratorProtocol {
    mutating func next() -> Int? {
        return 0
    }
}




struct FibsIterator: IteratorProtocol {
    var state = (0,1)
    mutating func next() -> Int? {
        let upcomingNumber = state.0
        state = (state.1, state.0 + state.1)
        return upcomingNumber
    }
}
var iterator = FibsIterator()
//while let num = iterator.next() {
//    print(num)
//}


struct PrefixIterator: IteratorProtocol {
    let string: String
    var offset: String.Index
    
    init(string: String) {
        self.string = string
        offset = string.startIndex
    }
    
    mutating func next() -> Substring? {
        guard offset < string.endIndex else { return nil }
        offset = string.index(after: offset)
        return string[..<offset]
    }
}

struct PrefixSequence: Sequence {
    let string: String
    func makeIterator() -> PrefixIterator {
        return PrefixIterator(string: string)
    }
}



let result = PrefixSequence(string: "Christopher Karani").map { $0.uppercased() }
result.forEach { prefix in
//    print(prefix)
}


let seq = stride(from: 0, to: 60000, by: 8000)
for x in seq {
    print(x)
}


class Lizard {
    var name: String
}



