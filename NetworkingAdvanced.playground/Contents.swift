//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport


extension Data {
    /** convienient way to check data string */
    var stringDescription: String {
        return String(data: self, encoding: .utf8)!
    }
}

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
//    static let all = Resource<[Post]>(url: url!, parseJSON: { (data) -> [Post]? in
//        let decoder = JSONDecoder()
//        return try? decoder.decode([Post].self, from: data)
//    })
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
    var method: HttpMethod<Data>
    var parse : (Data) -> T?
}
extension HttpMethod {
    func map<T>(_ f: (Body) -> T ) -> HttpMethod<T> {
        switch self {
        case .get: return .get
        case .post(let body):
            return .post(f(body))
        }
    }
}


extension Resource where T: Codable {
    init(url: URL, method: HttpMethod<Any>, parseJSON: (Data) -> T?) {
        self.url = url
        self.method = method.map { data in
            try! JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
        }
        self.parse = { data in
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let jsonDecode = try? decoder.decode(T.self, from: data)
            return jsonDecode
        }
    }
    
}
func postResource(for post: Post) -> Resource<Post> {
    let url = Post.postUrl!
    let postJSONDictionary : [String: Any] = ["id": post.id,
                              "userId": post.userID,
                              "title": post.title,
                              "body": post.body]
    
    let postResource = Resource<Post>(url: url, method: .post(postJSONDictionary), parseJSON: { (data) -> Post? in
        let decoder = JSONDecoder()
        let response = try! decoder.decode(Post.self, from: data)
        return response
    })
    return postResource
}

enum HttpMethod<Body> {
    case get
    case post(Body)
}

extension HttpMethod {
    var method: String {
        switch self {
        case .get: return "GET"
        case .post: return "POST"
        }
    }
}

extension URLRequest {
    init<A>( _ resource: Resource<A>) {
        self.init(url: resource.url)
        httpMethod = resource.method.method
        if case let .post(data) = resource.method {
            httpBody = data
        }
    }
}

final class Webservice {
    func load<A>(resource: Resource<A>, completion: @escaping (A?) -> () ) {
        let request = URLRequest(url: resource.url)
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            completion(resource.parse(data!))
        }.resume()
    }
    
}

let usersResource = Resource<[User]>(url: usersUrl!, method: .get, parse: { (data) -> [User]? in
    let decoder = JSONDecoder()
    let user = try! decoder.decode([User].self, from: data)
    return user
})

var postsX = [Post]()
//Webservice().load(resource: Post.all) { (posts) in
//    //guard let unwrapppedPosts = posts else {return }
//}
//
//Webservice().load(resource: usersResource) { (users) in
//   // guard let users = users else { return }
//}


struct Sprite: Codable {
    let frontDefault: String
    let frontShiny: String
}

extension Sprite {
    static func resource(for url: URL) -> Resource<UIImage> {
        return Resource<UIImage>(url: url, method: .get, parse: { (data) -> UIImage? in
            return  UIImage(data: data)
        })
    }

}


struct Pikachu: Codable {
    static let url = URL(string: "http://pokeapi.co/api/v2/pokemon/pikachu")
    var id: Int
    var name: String
    var sprites : Sprite
}

let pokemonResource = Resource<Pikachu>(url: Pikachu.url!, method: .get, parse: { data in
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    let pikachu = try! decoder.decode(Pikachu.self, from: data)
    return pikachu
})


struct DataStorage<T> {
    private var data = [T]()
    
    mutating public func insert(data t: T) {
        data.append(t)
    }
    
    mutating public func pop() -> T? {
        guard !data.isEmpty else { return nil }
        return data.removeLast()
    }
    
    public func read() -> [T] {
        return data
    }
    
    public func statusPrint() {
        print("Number of Items in collection: \(data.count)")
    }
}

var imageStore = DataStorage<UIImage>()



Webservice().load(resource: pokemonResource) { (pokemon) in
    guard let pikachu = pokemon else { return }
    guard let urlFront = URL(string: pikachu.sprites.frontDefault) else { fatalError() }
    Webservice().load(resource: Sprite.resource(for: urlFront), completion: { (image) in
        guard let anImage = image  else { return }
        imageStore.insert(data: anImage)
    })
}




class CustomCollectionCell: UICollectionViewCell {
    static var id : String {
        return "CellID"
    }
    var imageView : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.rightAnchor.constraint(equalTo: rightAnchor),
            imageView.leftAnchor.constraint(equalTo: leftAnchor)
            ])
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CollectionViewDelegate: NSObject, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let dimension = (collectionView.frame.width - 2) / 3
        return CGSize(width: dimension, height: dimension)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat { return 1 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat { return 1 }
}

class CollectionViewDataSource: NSObject, UICollectionViewDataSource {
    var items = imageStore.read()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionCell.id, for: indexPath) as! CustomCollectionCell
         let media = items[indexPath.item]
        cell.imageView.image = media
        return cell
        
    }
}

class CollectionViewController: UICollectionViewController {
    let delegate = CollectionViewDelegate()
    let dataSource = CollectionViewDataSource()
    func setupCell() {
        collectionView?.register(CustomCollectionCell.self, forCellWithReuseIdentifier: CustomCollectionCell.id)
        
        collectionView?.dataSource = dataSource
        collectionView?.delegate = delegate
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCell()
    }
}

let postablePost = Post(userID: 45, id: 666, title: "I Posted This Story", body: "This story was posted from a Macbook pro, and this network request was done in swift")

let postRes = postResource(for: postablePost)
Webservice().load(resource: postRes) { (post) in
    guard let post = post else {
        print("No post response")
        return
    }
    
    print(post)
}





PlaygroundPage.current.needsIndefiniteExecution = true
//PlaygroundPage.current.liveView = CollectionViewController()

