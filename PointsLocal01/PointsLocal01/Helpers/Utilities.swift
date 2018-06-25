import UIKit

let group:String = "events"

func getCategoryColor(group:String, category:String) -> String {
    var categoryColors: [String: String] = [:]
    
    if group == "music" {
        categoryColors = [
            "Alternative": "#baba71",
            "Country": "#ae0000",
            "Hip Hop": "#f477c5",
            "Pop": "#f477c5",
            "Rock": "#003264"
        ]
    }
    
    if group == "events" {
        categoryColors = [
            "Art Galleries & Exhibits": "#222",
            "Comedy": "#baba71",
            "Festivals": "#ae0000",
            "Food & Wine": "#666",
            "Outdoors & Recreation": "#003264"
        ]
    }
    
    guard let color = categoryColors[category] else { return "#999" }
    
    return color
}

func stripHTML(copy:String) -> String {
    let bodyCopy = copy.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil)
    return bodyCopy
}
