var str = "Hello, playground"

protocol ScoreConvertible {
    func convertScore()
}

protocol Animal {
    func breath()
}

class Box<T> {
    var value: T
    
    init(value: T) {
        self.value = value
    }
    
    func getValue() -> T {
        return value
    }
}

struct User: Equatable {
    var name: String
    var age: Int
    
    static func == ( _ lhs: User, _ rhs : User) -> Bool {
        return lhs.name == rhs.name
    }
}




let chris = User(name: "Christopher", age: 22)
let carlton = User(name: "Carlton", age: 13)

chris == carlton


let refrenceUser = Box(value: chris)
let referenceUser2 = Box(value: carlton)




chris.name
refrenceUser.value.name
refrenceUser.getValue().age

extension Box: Equatable where T: Equatable {
    static func == (_ lhs: Box<T>, _ rhs: Box<T>) -> Bool {
        return lhs.value == rhs.value
    }
}

refrenceUser == referenceUser2
refrenceUser.value.name
referenceUser2.value.name

print("hello")


let array = [1,2,3,4,10,11]

func simpleArraySum(ar: [Int]) -> Int {
    return ar.reduce(0, { (result, nextNumber) -> Int in
        return result + nextNumber
    })
}


func solve(a0: Int, a1: Int, a2: Int, b0: Int, b1: Int, b2: Int) -> [Int] {
    let firstArray = [a0, a1, a2,]
    let secondArray = [b0, b1, b2]
    
    
    
    var aliceScroe: Int = 0
    var bobScore : Int = 0
    for (a,b) in zip(firstArray, secondArray) {
        if a > b {
            aliceScroe += 1
        } else if a == b {
            continue
        } else {
            bobScore += 1
        }
    }
    
    return [aliceScroe, bobScore]
}

solve(a0: 5, a1: 6, a2: 7, b0: 3, b1: 6, b2: 10)



