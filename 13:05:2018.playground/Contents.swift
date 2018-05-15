import Foundation
import PlaygroundSupport

let decoder = JSONDecoder()

extension Data {
    var stringDescription: String {
        return String(data: self, encoding: .utf8)!
    }
}

struct Resource<T> {
    let url : URL
    let parse : (Data) -> T?
}

struct SpriteResource: Codable {
    var frontDefault: String
    var frontShiny: String
}




struct Pokemon: Codable {
    public let url: String
    public var name: String
    static var all = [Pokemon]()
}

struct PokemonResource: Decodable {
    var sprites: SpriteResource
}




struct PokeMapper: Codable {
    static let retrieveLimit = 10
    static let url = URL(string: "https://pokeapi.co/api/v2/pokemon/?limit=\(retrieveLimit)")!
    let count: Int
    let next: String
    let previous: String?
    let results : [Pokemon]
}



class WebService {
    func load<A>(_ resource: Resource<A>, completion: @escaping (A?) -> ()) {
        URLSession.shared.dataTask(with: resource.url) { (data, _, _) in
            guard let data = data else { return }
            completion(resource.parse(data))
        }.resume()
    }
}

let allPokemonUrl = URL(string: "https://pokeapi.co/api/v2/pokemon/?limit=800")!

let mapperResource = Resource<PokeMapper>(url: PokeMapper.url) { (data) -> PokeMapper? in
    return try! decoder.decode(PokeMapper.self, from: data)
}

let group = DispatchGroup()
func loadData() {
    group.enter()
    WebService().load(mapperResource) { (mapper) in
        print(mapper!.next)
        mapper!.results.map { pokemon in
            Pokemon.all.append(pokemon)
        }
        group.leave()
    }
}

let secondGroup = DispatchGroup()


loadData()

func loadPokemonResource(with pokemonResource: Resource<PokemonResource>) {
    WebService().load(pokemonResource, completion: { (resource) in
        secondGroup.leave()
    })
}
func makePokemondResource(_ url: URL) -> Resource<PokemonResource> {
    let pokemonResource = Resource<PokemonResource>(url: url, parse: { (data) -> PokemonResource? in
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try! decoder.decode(PokemonResource.self, from: data)
    })
    return pokemonResource
}



group.notify(queue: .main) {
    for pokemon in Pokemon.all {
        guard let url = URL(string: pokemon.url) else { return }
        secondGroup.enter()
        let resource = makePokemondResource(url)
        loadPokemonResource(with: resource)
    }
}

extension Character {
    var isInteger: Bool {
        let string = String(self)
        return Int(string) != nil
    }
}


secondGroup.notify(queue: .main) {
    print("Done")
}

extension Character {
    func isEqual(to char: Character) -> Bool {
        return self == char
    }

    func notEqual(to char: Character) -> Bool {
        return self != char
    }
}

extension Array {
    //combine numbers array to form a string
    func combinePokedexNumbers() -> String {
        var str = self.reduce(""){ value, result in
            return "\(value)\(result)"
        }
        str.insert("#", at: str.startIndex)
        return str
    }
}

extension String {
    var toCharacter: Character {
        return Character(self)
    }
}

extension Array {
    func removeElement(_ item: Element) {
        
    }
}

let v = "v"
let char1 = v.toCharacter
let char2 = Character("v")

char2.isEqual(to: char1)


let urlString = "https://pokeapi.co/api/v2/pokemon/200/"

func find(insideString text: String) -> String {
    var originalArray = text.reversed().filter { char in
        return char.notEqual(to: "/")
        }
    var lastCharacter = Character("*")
    _ = originalArray.map { (char) -> Character? in
        if char.isEqual(to: "v".toCharacter) {
            if let index = originalArray.index(of: lastCharacter) {
                print(index)
                originalArray.remove(at: index)
                return nil
            }
        }
        lastCharacter = char;
        if char.isInteger {
            return char
        }
        return nil
    }
    
    let numbersOnly = originalArray.flatMap { char -> Character? in
        if char.isInteger {
            return char
        }
        return nil
    }
    
    let str = numbersOnly.combinePokedexNumbers()
    
    return str
}


func find(inside text: String) -> String {
    var originalArray = text.reversed().filter { char in
        return char.notEqual(to: "/")
    }
    
    for char in originalArray where char.isEqual(to: "v".toCharacter) {
        guard let index = originalArray.index(of: char) else { fatalError() }
        originalArray.remove(at: index - 1) // remove value before
    }
    
    let numbersOnly = originalArray.compactMap { char -> Character? in
        if char.isInteger {
            return char
        }
        return nil
    }
    
    let str = numbersOnly.combinePokedexNumbers()
    return str
}

find(inside: urlString)

find(insideString: urlString)

PlaygroundPage.current.needsIndefiniteExecution = true
