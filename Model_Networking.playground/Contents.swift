//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

struct Pokemon {
    private var baseString = "http://pokeapi.co/api/v2/"
    public var baseUrl: URL {
        guard let url = URL(string: self.baseString) else { return  URL(string: "")! }
        return url
    }
}
struct JSONPlaceHolder {}


struct Resource<T> {
    let url : URL
    let parseData : (Data) -> T?
}


