//: Playground - noun: a place where people can play

import Foundation

var str = "Hello, playground"

enum AlphaBet: String {
    case a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z
}

extension AlphaBet {
    func returnLetter() -> String {
        switch self {
        case .a:
            return "b"
        case .b:
            return "c"
        case .c:
            return "d"
        case .d:
            return "e"
        case .e:
            return "f"
        case .f:
            return "g"
        case .g:
            return "h"
        case .h:
            return "i"
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
        default:
            return "Z"
        }
    }
}


func letterChanges(_ str: String) {
    for i in str {
        print(i)
    }
}

//let alphabet = "A"..."Z"





//letterChanges(str)

