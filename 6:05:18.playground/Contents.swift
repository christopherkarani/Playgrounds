
import Foundation

var str = "Hello, playground"

let numbers = [1,2,3,4,5]
var exampleInputString = "Happy, Friendly, lazy, cocky"


let startIndex = exampleInputString.startIndex
let endIndex = exampleInputString.index(str.startIndex, offsetBy: 4)
let word = exampleInputString[startIndex...endIndex]

var resultsArray = [String]()

var stepIndex : String.Index?

for char in exampleInputString {
    if char == "," {
        if let steppedOnIndex = stepIndex {
            if let index = exampleInputString.index(of: char) {
                print(exampleInputString[steppedOnIndex..<index])
                let word = String(exampleInputString[steppedOnIndex..<index])
                resultsArray.append(word)
                exampleInputString.remove(at: index)
                stepIndex = index
            }
        } else if let index = exampleInputString.index(of: char) {
            print(exampleInputString[startIndex..<index])
            let word = String(exampleInputString[startIndex..<index])
            resultsArray.append(word)
            exampleInputString.remove(at: index)
            stepIndex = index
        }
    }
}

// The string Value we want from the substring
var stringValue = String()

let strings = exampleInputString.split { (char) -> Bool in
    return char == ","
}
exampleInputString.split(separator: ",")
let tags = exampleInputString.components(separatedBy: " ")

let testArray = [1,2,3,4,5]
testArray.reduce(0) { (res, str) -> Int in
    return res + str
}
tags.reduce("") { (result, word) -> String in
    return "\(result) \(word)"
}

















