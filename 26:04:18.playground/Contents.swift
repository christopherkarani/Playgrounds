import Foundation

var str = "Hello, playground"

extension Data {
    var stringDescription: String {
        return String(data: self, encoding: .utf8)!
    }
}


print(str)

let json = """
{
    "work": {
        "id": 2422333,
        "popularity": null,
        "sponsor": "Random Publisher, Inc",
        "books_count": 222,
        "ratings_count": 860687,
        "text_reviews_count": 37786,
        "best_book": {
            "id": 375802,
            "title": "Ender's Game (Ender's Saga, #1)",
            "author": {
                "id": 589,
                "name": "Orson Scott Card"
            }
        },
     "candidates": [
            {
                "id": 44687,
                "title": "Enchanters' End Game (The Belgariad, #5)",
                "author": {
                    "id": 8732,
                    "name": "David Eddings"
                }
            },
            {
                "id": 22874150,
                "title": "The End Game",
                "author": {
                    "id": 6876994,
                    "name": "Kate  McCarthy"
                }
            },
            {
                "id": 7734468,
                "title": "Ender's Game: War of Gifts",
                "author": {
                    "id": 236462,
                    "name": "Jake Black"
                }
            }
        ]
    }
}
""".data(using: .utf8)!

struct Author: Codable {
    let id: Int
    let name: String
}

struct Book: Codable {
    let id: Int
    let title: String
    let author: Author
}

struct SearchResult: Decodable {
    let id: Int
    let booksCount: Int
    let ratingsCount: Int
    let textReviewsCount: Int
    let bestBook: Book
    let candidates: [Book]
    
    enum OuterKeys: String, CodingKey {
        case work, candidates
    }
    
    enum InnerKeys: String, CodingKey {
        case id
        case booksCount
        case ratingsCount
        case textReviewsCount
        case bestBook
        case candidates
    }
    
    init (from decoder: Decoder) throws {
        let outercontainer = try decoder.container(keyedBy: OuterKeys.self)
        let innerContainer = try outercontainer.nestedContainer(keyedBy: InnerKeys.self, forKey: .work)
        id = try! innerContainer.decode(Int.self, forKey: .id)
        booksCount = try! innerContainer.decode(Int.self, forKey: .booksCount)
        ratingsCount = try! innerContainer.decode(Int.self, forKey: .ratingsCount)
        textReviewsCount = try! innerContainer.decode(Int.self, forKey: .textReviewsCount)
        bestBook = try! innerContainer.decode(Book.self, forKey: .bestBook)
        candidates = try! innerContainer.decode([Book].self, forKey: .candidates)
    }
}

extension SearchResult: Encodable{
    func encode(to encoder: Encoder) throws {
        var outerContainer =  encoder.container(keyedBy: OuterKeys.self)
        var innerContainer =  outerContainer.nestedContainer(keyedBy: InnerKeys.self, forKey: .work)
        try innerContainer.encode(id, forKey: .id)
        try innerContainer.encode(booksCount, forKey: .booksCount)
        try innerContainer.encode(ratingsCount, forKey: .ratingsCount)
        try innerContainer.encode(textReviewsCount, forKey: .textReviewsCount)
        try innerContainer.encode(bestBook, forKey: .bestBook)
        try innerContainer.encode(candidates, forKey: .candidates)
    }
}

let decoder = JSONDecoder()
decoder.keyDecodingStrategy = .convertFromSnakeCase

let encoder = JSONEncoder()
encoder.keyEncodingStrategy = .convertToSnakeCase

let result = try! decoder.decode(SearchResult.self, from: json)
let encodedResult = try! encoder.encode(result)

print(encodedResult.stringDescription)
print(result.booksCount)

let jsonTwo = """
{
  "result": {
    "title": "My First Blog Post",
    "author": "Pasan Premaratne",
    "date": "April 16, 2018"
  }
}
""".data(using: .utf8)!

struct Post: Codable {
    let title: String
    let author: String
    let date: String
}


let post = try! decoder.decode([String:Post].self, from: jsonTwo)


let jsonThree = """
{
  "results": [
    {
      "code": 200
    },
    {
      "code": 401
    },
    {
      "code": 320
    }
  ]
}
""".data(using: .utf8)!

struct Status: Codable {
    let code: Int
}


let statusStuff = try! decoder.decode([String : [Status]].self, from: jsonThree)
statusStuff.count
statusStuff.forEach { (key, value) in
    value.forEach({ (status) in
        print(status.code)
    })
}

let jsonFour = """
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
}

struct Transaction: Decodable {
    let side : String
    let transactionType: String
    let amount: String
    let balance: String
    let accountType: String
    let transactionId: String
    let timeStamp: String
}

let randomString = (UUID().uuidString)
let transactionsJSON = """
{
    "transactions":[
    {
        "transaction":{
            "side":"CR",
            "TransactionType":"Funding",
            "amount":"100.00",
            "balance":"100.00",
            "accountType":"KK",
            "transactionId":"\(randomString)",
            "timestamp":"2017-09-10 18:14::45"
            }
        }
    ]
}
""".data(using: .utf8)!




















