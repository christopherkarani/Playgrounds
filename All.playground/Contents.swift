import Foundation

var str = "Hello, Kiannah"

let startIndex = str.index(str.startIndex, offsetBy: 6)
var hello = str[str.startIndex...str.index(str.startIndex, offsetBy: 4)]
var kiannah = str[startIndex ..< str.endIndex]


struct MinMax {
    func miniMaxSum(arr: [Int]) -> Void {
        var result = arr
        var lastNumberIndex = 0
        var sumArray = [Int]()
        for number in result {
            if let index = result.index(of: number) {
                lastNumberIndex = result.remove(at: index) // we want it to crash and tell us why
                let sum = result.reduce(0, +)
                result.append(lastNumberIndex)
                sumArray.append(sum)
            }
        }
        let smallest = sumArray.min { $0 < $1 }
        let largest = sumArray.max { $0 < $1 }
        print(smallest!,largest!)
    }
}



// ---- Next Challenge Birthday Cake Candles

let testValue = [1,1,1,1,1,1,1,1,1,1,1,1,1]

var result = testValue
var maxValues = [Int]()
var lastIndexElement = 0
for _ in result {
    let largestNumber = result.max { $0 < $1}
    if largestNumber! >= lastIndexElement {
        if let index = result.index(of: largestNumber!) {
            lastIndexElement = result.remove(at: index)
//            print(lastIndexElement)
            maxValues.append(lastIndexElement)
        }
    }
}


func birthdayCakeCandles(n: Int, ar: [Int]) -> Int {
    var result = ar
    var largestValues = [Int]()
    var last = 0
    for _ in result {
        let largestNumber = result.max { $0 < $1}
        if largestNumber! >= last {
            if let index = result.index(of: largestNumber!) {
                last = result.remove(at: index)
                largestValues.append(last)
            }
        }
    }
    return largestValues.count
}



print(birthdayCakeCandles(n: testValue.count, ar: testValue))


















