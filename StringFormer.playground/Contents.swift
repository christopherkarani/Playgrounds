//: Playground - noun: a place where people can play

import Foundation



var testValues = ["7", "13", "115", "2345"]



struct StringFormatter {
    let str: String
    typealias PokeDexNumberFormat = String
}

extension StringFormatter {
    func stringFormat() -> PokeDexNumberFormat {
        var result = str
        if str.count == 1 {
            // running repetitive task
            for _ in 0...1 {
                result.insert("0", at: str.startIndex)
            }
            return result
        } else if str.count == 2 {
            result.insert("0", at: str.startIndex)
            return result
        }
        return ""
    }
}



for value in testValues {
    let formatter = StringFormatter(str: value)
    let result = formatter.stringFormat()
    print(result)
}




