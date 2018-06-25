import UIKit

struct Branding:Decodable {
    let logo:String?
    let colorMain:String?
}

struct Feed:Decodable {
    let version:String?
    let title:String?
    let items:[Article]?
    
    static func downloadData(feedUrl:String, completion: @escaping ([Article]) -> Void) {
        let urlString = "http://rtodd.net/swift/data/\(feedUrl).json"
        let url = URL(string: urlString)
        
        if let urlObject = url {
            URLSession.shared.dataTask(with: urlObject) { (data, response, error) in
                guard let data = data else { return }
                
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let feed = try decoder.decode(Feed.self, from: data)
                    
                    let articles = feed.items
                    
                    DispatchQueue.main.async {
                        guard let dataArticles = articles else { return }
                        completion(dataArticles)
                    }
                    
                } catch let jsonErr {
                    print("we got an error \(jsonErr)")
                }
                
                }.resume()
        }
    }
}

struct Article:Decodable {
    let category:Category?
    let headline:String?
    let date:String?
    let creator:Creator?
    let summary:String?
    let fullText:String?
    let leadMedia:MediaItem?
    let media:[MediaItem]?
    let locations:[Location]?
    let relatedContent:Related?
    
    private enum CodingKeys:String, CodingKey {
        case category, headline, creator, summary, fullText, leadMedia, media, locations, relatedContent
        case date = "pubDate"
    }
}

struct Related:Decodable {
    let title:String?
    let items:[Item]?
}

struct MediaItem:Decodable {
    let type:String?
    let path:String?
    let title:String?
    let caption:String?
    let credit:String?
}

struct Creator:Decodable {
    let name:String?
    let title:String?
    let image:String?
}

struct Category:Decodable {
    let title:String?
}

struct Location:Decodable {
    let latitude:Float?
    let longitude:Float?
    let name:String?
}

struct Item:Decodable {
    let headline:String?
    let summary:String?
    let date:String?
    let leadMedia:MediaItem?
    let guid:String?
    
    private enum CodingKeys:String, CodingKey {
        case headline, summary, leadMedia, guid
        case date = "pubDate"
    }
}
