import Foundation

let json = """
{
    "title": "Harry Potter and the sorcerer's stone",
    "url": "https:\\/\\/openlibrary.org\\/books\\/OL26331930M\\/Harry_Potter_and_the_sorcerer's_stone",
    "publish_date": "1997-06-26T00:00:00+0000",
    "text": "VGhpcyBpc24ndCByZWFsbHkgdGhlIGNvbnRlbnRzIG9mIHRoZSBib29r",
    "rating": 4.9
    
}
""".data(using: .utf8)!

let secondJson = """
{
    "title": "Sample Konfabulator Widget",
    "name": "main_window",
    "width": 500,
    "height": 500
}
""".data(using: .utf8)!

struct Window: Decodable {
    var title: String
    var name: String
    var width: Int
    var height: Int
    
    enum Keys: String, CodingKey {
        case title = "title"
        case name = "name"
        case width = "width"
        case height = "height"
    }
    
    init (from decoder: Decoder) throws {
        let container = try! decoder.container(keyedBy: Keys.self)
        try name = container.decode(String.self, forKey: .name)
        try title = container.decode(String.self, forKey: .title)
        try width = container.decode(Int.self, forKey: .width)
        try height = container.decode(Int.self, forKey: .height)
    }
}

extension Window: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encode(name, forKey: .name)
        try container.encode(title, forKey: .title)
        try container.encode(width, forKey: .width)
        try container.encode(height, forKey: .height)
    }
}



struct Book: Codable {
    let title: String
    let url: String
    let publishDate: String
}

let decoder = JSONDecoder()
decoder.keyDecodingStrategy = .convertFromSnakeCase
let potter = try! decoder.decode(Book.self, from: json)

potter.title
potter.url
potter.publishDate
print("Hello")








