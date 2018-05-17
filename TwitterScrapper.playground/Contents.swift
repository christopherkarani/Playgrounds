import Foundation

struct CKDecoder<T: Decodable> {
    let decoder = JSONDecoder()
    
    func decode<T>(_ item: T, _ data: Data) -> T {
        let item = try! decoder.decode(item.self, from: data)
        return item
    }
}

//test data
struct PokemonResource {
    private let name: String
    private let urlString: String
    
    enum Keys: CodingKey {
        case url
        case name
    }
}

struct PokemonWrapper {
    let count: String
    let previous: String?
    let result : [PokemonResource]
}


// Tiny Networking Library
struct Rescource<T> {
    let url: URL
    let parse : (Data) -> T
}

protocol Webservice {
    func load<T>(_ resource: Rescource<T>, completion: @escaping(T?) -> ())
}

extension Webservice {
    func load<T>(_ resource: Rescource<T>, completion: @escaping(T?) -> ()) {
        URLSession.shared.dataTask(with: resource.url) { (data, _, _) in
            guard let data = data else { return }
            completion(resource.parse(data))
        }
    }
}

struct NetworkManager: Webservice {
    var urlString: String
    var url : URL {
        return URL(string: urlString) ?? URL(string: "")! // dangerous, only for testing
    }
}

let urlString = "http://pokeapi.co/api/v2/pokemon"

let apiManager = NetworkManager(urlString: urlString)



//let resource = Rescource<PokemonWrapper>(url: apiManager.url) { (data) -> PokemonWrapper in
//    <#code#>
//}
//
//apiManager.load(<#T##resource: Rescource<T>##Rescource<T>#>, completion: <#T##(T?) -> ()#>)
