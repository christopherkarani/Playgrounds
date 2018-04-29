//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


protocol Logging {
    func log(_ message: String)
}
extension Logging {
    func log(_ message: String) {
        LogginManager.shared.logMessage(withMessage: message)
    }
}
struct LogginManager {
    static let shared = LogginManager()
    func logMessage(withMessage message: String) {
        print(message)
    }
}



struct House : Logging {
    func callLoggin() {
        log("Hello World")
    }
}


let house = House()

house.callLoggin()



