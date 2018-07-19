//: Playground - noun: a place where people can play

import Foundation

var str = "Hello, playground"

extension Bool {
    mutating func toggle()  {
        self = !self
    }
}

var gay : Bool = false
gay.toggle()

enum AlphaBet: String {
    case a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z
}

extension AlphaBet {
    static func returnLetter(input: AlphaBet) -> Character {
        switch input {
        case .a:
            return "b"
        case .b:
            return "c"
        case .c:
            return "d"
        case .d:
            return "E"
        case .e:
            return "f"
        case .f:
            return "g"
        case .g:
            return "h"
        case .h:
            return "I"
        case .i:
            return "j"
        case .j:
            return "k"
        case .k:
            return "l"
        case .m:
            return "n"
        case .n:
            return "O"
        case .o:
            return "O"
        case .p:
            return "q"
        case .q:
            return "r"
        case .s:
            return "s"
        case .t:
            return "U"
        case .v:
            return "w"
        case .w:
            return "x"
        case .x:
            return "y"
        case .z:
            return "a"
        case .l:
            return "m"
        case .r:
            return "s"
        case .u:
            return "v"
        case .y:
            return "z"
        }
    }
}

extension AlphaBet {
    static func all() -> [AlphaBet] {
        return [.a,.b,.c,.d,.e,.f,.g,.h,.i,.j,.k,.l,.m,.n,.o,.p,.q,.r,.s,.t,.u,.v,.w,.x,.y,.z]
    }
}


let startChar = Unicode.Scalar("A").value
let endChar = Unicode.Scalar("Z").value


for letter in str {
    for alphabet in startChar...endChar {
        if let char = Unicode.Scalar(alphabet) {
            print(char)
            if letter == Character(char) {
                print(char)
            }
        }
    }
}


//letterChanges(str)

