import Foundation


let json = """
{
  "languages": {
    "python": {
      "designer": [
        "Guido van Rossum"
      ],
      "released": "20 February 1991"
    },
    "java": {
      "designer": [
        "James Gosling"
      ],
      "released": "May 23, 1995"
    },
    "swift": {
      "designer": [
        "Chris Lattner",
        "Apple Inc"
      ],
      "released": "June 2, 2014"
    },
    "ruby": {
      "designer": [
        "Yukihiro Matsumoto"
      ],
      "released": "1995"
    }
  }
}
""".data(using: .utf8)!

struct Language {
    let name: String
    let designer: [String]
    let releaseDate: String
}

struct Library {
    let languages: [Language]
    
    struct LibraryKeys: CodingKey {
        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        
        var intValue: Int? { return nil}
        init?(intValue: Int) { return nil}
        
        static let languages = LibraryKeys(stringValue: "languages")!
    }
    
    enum LanguageKeys: String, CodingKey {
        case designer
        case released
    }
}

extension Library: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: LibraryKeys.self)
        let languagesContainer = try container.nestedContainer(keyedBy: LibraryKeys.self, forKey: .languages)
        languages = try languagesContainer.allKeys.map {
            let languageContainer = try languagesContainer.nestedContainer(keyedBy: LanguageKeys.self, forKey: $0)
            let name = $0.stringValue
            let designer = try languageContainer.decode([String].self, forKey: .designer)
            let released = try languageContainer.decode(String.self, forKey: .released)
            
            return Language(name: name, designer: designer, releaseDate: released)
        }
    }
}

let decoder = JSONDecoder()
let lib = try! decoder.decode(Library.self, from: json)

lib.languages.forEach {
    print($0.name)
}

