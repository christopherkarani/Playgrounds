import UIKit
import PlaygroundSupport


var str = "Hello, playground"

let array = NSMutableArray(array: [1,2,3])
let b = array.copy() as! NSArray
let names = ["Paula", "Elena", "Zoe"]


let familyNames = ["Christopher", "Kiannah", "Carlton", "Debbie", "Pato"]

//find the last leter of names


extension Array {
    func containsSuffix(where predicate: (Element) -> Bool) -> Element? {
        for value in reversed() where predicate(value) {
            return value
        }
        return nil
    }
}

let valuable = names.containsSuffix { str in str.hasSuffix("a") }
valuable!


extension Array {
    func loop(_ body: (Element) -> Void) {
        for i in  self {
            body(i)
        }
    }
}

struct Stack<T> {
    private var all = [T]()
    
    mutating func pop() -> T? {
        guard all.count > 0 else { return nil }
        return all.removeLast()
    }
    
    mutating func push(_ element: T) {
        all.insert(element, at: array.count)
    }
}

extension Array {
    func chrisMap<T>(_ transform: (Element) -> T) -> [T] {
        var result = [T]()
        result.reserveCapacity(count)
        for i in self {
            result.append(transform(i))
        }
        return result
    }
}

let squared : (Int) -> Int = { num in
    return num * num
}

var intToString : (String) -> Int = { string in
    return Int(string)!
}

let numbers = [2,3, 5,6,7,8]
let squaredNumbers = numbers.map { squared($0) }



let  stringNumbers = ["3", "5", "8", "10"]
let arr = stringNumbers
    .map { intToString($0) }
    .chrisMap { squared($0) }

extension Array {
    func calrtonMap<T> (_ transform: (Element) -> T) -> [T] {
        var result = [T]()
        result.reserveCapacity(count)
        for i in self {
            result.append(transform(i))
        }
        return result
    }
}

extension Array {
    func kiannahMap<T>(_ t: (Element) -> T) -> [T] {
        var result = [T]()
        result.reserveCapacity(count)
        for i in self {
            result.append(t(i))
        }
        return result
    }
}


extension Array {
    func accumulate<Result>(_ initialResult: Result, _ nextPartialResult: (Result, Element) -> Result) -> [Result] {
        var running = initialResult
        return map { next in
            running = nextPartialResult(running, next)
            return running
        }
    }
}


let sentenceFromArray = ["Chris ", "Had ", "A ", "Happy ", "Stay ", "With ", "Us"].accumulate("", +)
if var finalSentence = sentenceFromArray.last {
 // last sentence
    finalSentence += "."
}




extension Sequence {
    func combining<Result>(_ initialResult: Result, _ nextPartialResult: (Result, Element) -> Result) -> Result {
        var initial = initialResult
        for i in self {
            initial = nextPartialResult(initial, i)
        }
        return initial
    }
}

extension Sequence {
    func conatining2<T>(_ initialResult: T, _ nextPartialResult: (T,Element) -> T) -> T {
        var result = initialResult
        for i in self {
            result = nextPartialResult(result, i)
        }
        return result
    }
}



extension Sequence {
    func containing<Result>(_ initialResult : Result, _ nextPartialResult: (Result, Element) -> Result ) -> Result {
        var result = initialResult
        for element in self {
            result = nextPartialResult(result, element)
        }
        return result
    }
    
    func filter2(_ isIncluded: (Element) -> Bool) -> [Element] {
        return reduce([]) {
            isIncluded($1) ? $0 + [$1] : $0
        }
    }

}



enum HttpMethod {
    case get
    case post
}
extension HttpMethod: CustomStringConvertible {
    var description: String {
        switch self {
        case .get: return "GET"
        case .post: return "POST"
        }
    }
}

let stringToKiannah = "Hello Kiannah, in this string I have contained my deepest secrets"

let method : HttpMethod = .get
let characterArray = "The method \(method.description)".map { char in
    return "\(char)\(UUID().uuidString.first!)"
}

let  lockCollection = stringToKiannah.map { char in
    return "\(char)\(UUID().uuidString.first!)"
}


func sumXX(_ lhs: Int, _ rhs: Int) -> Int {
    return lhs + rhs
}

let sum : (Int, Int) -> Int = { num1, num2 in
    return num1 + num2
}

print(sum(5,5))

let numbersArray = [1,2,3,4,5,6]



extension Sequence {
    func map<T>(_ transform: (Element) throws -> T) rethrows -> [T] {
        var result = [T]()
        for element in self {
            result.append( try transform(element) )
        }
        return result
    }
}


func checkAge(_ age: Int) {
    guard age > 0 else {
        print("Invalid Input")
        return
    }
    
    switch age {
    case 0..<6: print("Your are a toddler")
    case 6..<14: print("Your are a child")
    case 14..<21: print("You are a teenager")
    default: print("Your an adult")
    }
}


let check : (Int) -> () = { num in
    
}

if let twentyTwo = Int("22") {
    checkAge(twentyTwo)
}

class Webservice {
    
}

//handle the error


class ViewController: UIViewController {
    let shapeLayer = CAShapeLayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        let path = UIBezierPath(arcCenter: view.center, radius: 100, startAngle: -.pi / 2, endAngle: .pi * 2, clockwise: true)
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = UIColor.orange.cgColor
        shapeLayer.lineCap = kCALineCapRound
        shapeLayer.lineWidth = 10
        shapeLayer.strokeEnd = 0
        view.layer.addSublayer(shapeLayer)
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapGesture)))
    }
    
    @objc func handleTapGesture() {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 1
        basicAnimation.duration = 1
        basicAnimation.fillMode = kCAFillModeForwards
        basicAnimation.isRemovedOnCompletion = false
        shapeLayer.add(basicAnimation, forKey: "animation")
    }
}

let vc = ViewController()
PlaygroundPage.current.liveView = ViewController()


























