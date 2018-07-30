//: Playground - noun: a place where people can play

import Foundation
import PlaygroundSupport
var str = "Hello, playground"

struct Post: Decodable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}


let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
URLSession.shared.dataTask(with: url) { (data, response, error) in
    if let error = error {
        print(error)
        return
    }
    
    guard let data = data else { return }
    let decoder = JSONDecoder()
    let posts = try! decoder.decode([Post].self, from: data)
    let filtered = posts.filter { post in
        return post.userId == 7
    }
    filtered.forEach { post in
        print(post.title)
    }
    
}.resume()


PlaygroundPage.current.needsIndefiniteExecution = true
