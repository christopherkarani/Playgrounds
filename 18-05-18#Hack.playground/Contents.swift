//: Playground - noun: a place where people can play

import Foundation

var str = "Hello, playground"



func birthdayCakeCandles(n: Int, ar: [Int]) -> Int {
    var result = (max: 0, counter: 0)
    for number in ar where number > result.max {
        result.max = number
        if number == result.max {
            print(number)
            print("Identical Result")
            result.counter += 1
            break
        }
    }
    return result.counter
}

birthdayCakeCandles(n: example.count, ar: example)
