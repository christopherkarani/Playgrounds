
let arr = [1000000001, 1000000002, 1000000003, 1000000004, 1000000005]

func aVeryBigSum(n: Int, ar: [Int]) -> Int {
    return ar.reduce(0) { (result, number) -> Int in
        return result + number
    }
}

aVeryBigSum(n: 5, ar: arr)


var arr2 = [[11, 2, 4], [4, 5, 6], [10, 8, -12]]


let numberOfArrays = arr2.count
var secondaryIterator = numberOfArrays - 1
var iterator = 0
var primaryDiagonalSum = 0
var secondaryDiagonalSum = 0

while iterator < numberOfArrays {
    for array in arr2 {
        primaryDiagonalSum += array[iterator]
        iterator += 1
    }
}



while secondaryIterator >= 0 {
    for array in arr2  {
        secondaryDiagonalSum += array[secondaryIterator]
        secondaryIterator -= 1
    }
}

let total = primaryDiagonalSum - secondaryDiagonalSum
print(abs(total))












//for i in 0..<numberOfArrays {
//
//}



