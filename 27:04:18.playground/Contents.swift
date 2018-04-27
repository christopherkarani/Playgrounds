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
        
        init?(intValue: Int) { return nil}
        var intValue: Int? { return nil}
        
        static let languageKey = LibraryKeys(stringValue: "languages")!
    }
    
    enum LanguageKeys: String, CodingKey {
        case designer
        case released
    }
}

extension Library: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: LibraryKeys.self)
        let languagesContainer = try container.nestedContainer(keyedBy: LibraryKeys.self, forKey: .languageKey)
        self.languages = try languagesContainer.allKeys.map { (key) -> Language in
            let languageContainer = try languagesContainer.nestedContainer(keyedBy: LanguageKeys.self, forKey: key)
            let languageName = key.stringValue
            let languageDesigner = try languageContainer.decode([String].self, forKey: .designer)
            let languageReleaseDate = try languageContainer.decode(String.self, forKey: .released)
            return Language(name: languageName, designer: languageDesigner, releaseDate: languageReleaseDate)
        }
    }
}

let decoder = JSONDecoder()

let languages = try! decoder.decode(Library.self, from: json)
languages.languages.forEach { print($0.name) }



