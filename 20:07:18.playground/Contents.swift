//: Playground - noun: a place where people can play

import Foundation

var str = "Hello, playground"


// countable Range, half open
let countable = 1..<13

// countable closed range, closed range
let closedCountableRange = 1...13

// anything countable can be sequenced
// we cant iterate over range and closed range

let letter = "a"..."b"

// a countableRange is just like a range with the additional constraint that its element type conforms to Strideable.
// swift calls these more capable ranges, countable, because they can be iterated over

// The strdeable constaint enableds Countable Range and Countable CLosedRange to conform to RandomAccessCollection so we can iterate over them
// elements must be stride-able with integer steps

// Swift is able to distinguish between "normal" ranges with and element type that onlu conforms to Comparable protocol (which is the minimum req)
// And ranges that are Strideable and use integer steps between elements

for i in closedCountableRange {
    print(i)
}


// partial ranges
// the ranges are partial because they are missing one of their bounds
let partial = ...10
 // the only countable variant is CountablePartialRangeFrom, like the example above

// Partial range from cant be iterated over because its bound is not Strideable

public protocol RangeExp {
    associatedtype Bound: Comparable
    func contains(_ element: Bound) -> Bool
    func relatiive<C: Collection>(to collection: C) -> Range<Bound> where C.Index == Bound
}

let arr = [1,2,3,4]
arr[...2]
