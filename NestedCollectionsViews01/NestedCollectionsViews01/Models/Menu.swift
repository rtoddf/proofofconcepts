import UIKit

struct MenuItems:Decodable {
    let menuItems:[Menu]?
    
    static func downloadData(feedUrl:String, completion: @escaping ([Menu]) -> Void) {
        let urlString = feedUrl
        let url = URL(string: urlString)
        
        if let urlObject = url {
            URLSession.shared.dataTask(with: urlObject) { (data, ressponse, error) in
                guard let data = data else { return }
                
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let feed = try decoder.decode(MenuItems.self, from: data)
                    let menu = feed.menuItems
                    
                    DispatchQueue.main.async {
                        guard let dataMenu = menu else { return }
                        
                        completion(dataMenu)
                    }
                    
                } catch let jsonErr {
                    print("we got an error \(jsonErr)")
                }
                }.resume()
        }
    }
}

struct Menu:Decodable {
    let title:String?
}
