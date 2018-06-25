import UIKit

struct Events:Decodable {
    private enum CodingKeys:String, CodingKey {
        case events = "items"
    }
    
    let events:[Event]?
    
    static func downloadData(feedUrl:String, completion: @escaping ([Event]) -> Void) {
        let urlString = feedUrl
        let url = URL(string: urlString)
        
        if let urlObject = url {
            URLSession.shared.dataTask(with: urlObject) { (data, ressponse, error) in
                guard let data = data else { return }
                
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let feed = try decoder.decode(Events.self, from: data)
                    guard let events = feed.events else { return }
                    
                    DispatchQueue.main.async {
                        completion(events)
                    }
                    
                } catch let jsonErr {
                    print("we got an error \(jsonErr)")
                }
                }.resume()
        }
    }
}

struct Event:Decodable {
    let parentId:String?
    let headline:String?
    let date:String?
    let venueName:String?
    let venueAddress:String?
    let startTime:String?
    let endTime:String?
    let parentCategoryName:String?
    let fullText:String?
    
    private enum CodingKeys:String, CodingKey {
        case parentId, date, venueName, venueAddress, startTime, endTime, parentCategoryName
        case headline = "title"
        case fullText = "description"
    }
}
