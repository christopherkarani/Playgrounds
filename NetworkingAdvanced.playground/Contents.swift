//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

var str = "Hello, playground"

let url = URL(string: "https://jsonplaceholder.typicode.com/posts")
let usersUrl = URL(string: "https://jsonplaceholder.typicode.com/users")


struct Post {
    
    static let postUrl = URL(string: "https://jsonplaceholder.typicode.com/posts")
    
    
    let userID : Int
    let id : Int
    let title : String
    let body : String
    
    enum Keys: String, CodingKey {
        case userId
        case id
        case title
        case body
    }
}

extension Post: CustomStringConvertible {
    var description: String {
        return "title: \(self.title), id: \(self.id)"
    }
}

extension Post: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        id = try container.decode(Int.self, forKey: .id)
        userID = try container.decode(Int.self, forKey: .userId)
        title = try container.decode(String.self, forKey: .title)
        body = try container.decode(String.self, forKey: .body)
    }
}

extension Post: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encode(id, forKey: .id)
        try container.encode(userID, forKey: .userId)
        try container.encode(title, forKey: .title)
        try container.encode(body, forKey: .body)
    }
}

extension Post {
    static let all = Resource<[Post]>(url: url!, parseJSON: { (data) -> [Post]? in
        let decoder = JSONDecoder()
        return try? decoder.decode([Post].self, from: data)
    })
}


struct User: Codable {
    struct Address: Codable {
        struct Geo: Codable {
            let lat: String
            let lng: String
        }
        
        let street: String
        let suite: String
        let city: String
        let zipcode: String
        let geo : Geo
        
    }
    let id : Int
    let name: String
    let username: String
    let address: Address
}

struct Resource<T> {
    var url: URL
    var parse : (Data) -> T?
    var method: HttpMethod
}


extension Resource where T: Decodable {
    init(url: URL, method: HttpMethod = .get, parseJSON: (Data) -> T?) {
        self.url = url
//        switch method {
//        case .get: self.method = .get
//        case .post(let json):
//
//        }
        self.parse = { data in
            let decoder = JSONDecoder()
            let posts = try? decoder.decode(T.self, from: data)
            return posts
        }
    }
    
}
func postResource(for post: Post) -> Resource<Bool> {
    let url = Post.postUrl
    let encoder = JSONEncoder()
    let postJSON = try! encoder.encode(post)
    let resource = Resource<Bool>(url: url!, method: .post(<#T##Data#>), parseJSON: <#T##(Data) -> Bool?#>)
    
}

enum HttpMethod {
    case get
    case post(Data)
}

extension HttpMethod {
    var method: String {
        switch self {
        case .get: return "GET"
        case .post: return "POST"
        }
    }
}

final class Webservice {
    func load<A>(resource: Resource<A>, completion: @escaping (A?) -> () ) {
        URLSession.shared.dataTask(with: resource.url) { (data, _, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let data = data else {
                completion(nil)
                return
            }
            completion(resource.parse(data))
            
        }.resume()
    }
    
}

let usersResource = Resource<[User]>(url: usersUrl!) { (data) -> [User]? in
    let decoder = JSONDecoder()
    let user = try! decoder.decode([User].self, from: data)
    return user
}

var postsX = [Post]()
Webservice().load(resource: Post.all) { (posts) in
    guard let unwrapppedPosts = posts else {return }
    print(unwrapppedPosts.first!)
}

Webservice().load(resource: usersResource) { (users) in
    guard let users = users else { return }
}


struct Sprite: Codable {
    let frontDefault: String
    let frontShiny: String
}


struct Pikachu: Codable {
    static let url = URL(string: "http://pokeapi.co/api/v2/pokemon/pikachu")
    var id: Int
    var name: String
    var sprites : Sprite
}

let pokemonResource = Resource<Pikachu>(url: Pikachu.url!) { (data) -> Pikachu? in
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    let pikachu = try! decoder.decode(Pikachu.self, from: data)
    return pikachu
}



Webservice().load(resource: pokemonResource) { (pokemon) in
    //print(pokemon?.sprites)
    guard let pikachu = pokemon else { return }
    let urlFront = URL(string: pikachu.sprites.frontDefault)
    let spriteRescource = Resource<UIImage>(url: urlFront!, parse: { (data) -> UIImage? in
        let image = UIImage(data: data)
        return image
    })
    
    Webservice().load(resource: spriteRescource, completion: { (image) in
        
    })
}























PlaygroundPage.current.needsIndefiniteExecution = true
