import UIKit

extension UIFont {
    static var bodyFont:UIFont {
        guard let font = UIFont(name: "Helvetica", size: 13) else { return UIFont.systemFont(ofSize: 13) }
        return font
    }
    
    static var titleFont:UIFont {
        guard let font = UIFont(name: "Helvetica-Bold", size: 14) else { return UIFont.boldSystemFont(ofSize: 14) }
        return font
    }
    
    static var articleTitleFont:UIFont {
        guard let font = UIFont(name: "Helvetica-Bold", size: 24) else { return UIFont.boldSystemFont(ofSize: 24) }
        return font
    }
    
    static var labelFont:UIFont {
        guard let font = UIFont(name: "Helvetica", size: 11) else { return UIFont.systemFont(ofSize: 11) }
        return font
    }
    
    static var boldLabelFont:UIFont {
        guard let font = UIFont(name: "Helvetica-Bold", size: 10) else { return UIFont.boldSystemFont(ofSize: 10) }
        return font
    }
    
    static var extraLargeFont:UIFont {
        guard let font = UIFont(name: "Helvetica-Bold", size: 18) else { return UIFont.boldSystemFont(ofSize: 18) }
        return font
    }
    
    // events stuff
    static var eventHeadlineFont:UIFont {
        guard let font = UIFont(name: "Helvetica-Bold", size: 16) else { return UIFont.boldSystemFont(ofSize: 16) }
        return font
    }
    
    static var eventDetailsFont:UIFont {
        guard let font = UIFont(name: "Helvetica", size: 13) else { return UIFont.systemFont(ofSize: 13) }
        return font
    }
    
    static var eventBodyFont:UIFont {
        guard let font = UIFont(name: "Helvetica", size: 15) else { return UIFont.systemFont(ofSize: 15) }
        return font
    }
    
    // weather stuff
    static var weatherTempFont:UIFont {
        guard let font = UIFont(name: "Helvetica-Bold", size: 36) else { return UIFont.boldSystemFont(ofSize: 36) }
        return font
    }
    
    static var weatherDailyDateFont:UIFont {
        guard let font = UIFont(name: "Helvetica", size: 12) else { return UIFont.systemFont(ofSize: 12) }
        return font
    }
    
    static var weatherDailyTextFont:UIFont {
        guard let font = UIFont(name: "Helvetica", size: 14) else { return UIFont.systemFont(ofSize: 14) }
        return font
    }
    
    static var weatherDailyTempFont:UIFont {
        guard let font = UIFont(name: "Helvetica-Bold", size: 32) else { return UIFont.boldSystemFont(ofSize: 32) }
        return font
    }
    
    static var weatherHourlyTempFont:UIFont {
        guard let font = UIFont(name: "Helvetica-Bold", size: 24) else { return UIFont.boldSystemFont(ofSize: 24) }
        return font
    }
}

extension String {
    /// Converts HTML string to a `NSAttributedString`
    var htmlAttributedString: NSAttributedString? {
        return try? NSAttributedString(data: Data(utf8), options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
    }
    
    // http://nsdateformatter.com/
    func toDateString( inputDateFormat inputFormat  : String,  ouputDateFormat outputFormat  : String ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inputFormat
        let date = dateFormatter.date(from: self)
        dateFormatter.dateFormat = outputFormat
        return dateFormatter.string(from: date!)
    }
    
    func convertHtml() -> NSAttributedString{
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    
    func wrapHTML(width:CGFloat) -> String {
        let fontSize:String = "13"
        let margin:String = "10px 0 10px 0"
        let width:String = String(format:"%.2f", width)
        let color:String = "#666"
        
        var headHtml = """
        <html>
        <head>
        <meta name=\"viewport\" content=\"width=device-width, user-scalable=no, shrink-to-fit=no\">
        <style type=\"text/css\">
        body {
        -webkit-text-size-adjust: 100%;
        font-family: -apple-system, BlinkMacSystemFont, sans-serif;
        width: 100%;
        font-size: \(fontSize)px;
        color: \(color);
        word-wrap: break-word;
        height: auto;
        margin: 0;
        padding: 0;
        }
        h1,h2,h3,h4,h5,h6 {
        display: block;
        margin: \(margin);
        padding-top: 100px;
        }
        table {width: 100%;}
        img {
        width: \(width)px;
        height: auto;
        }
        </style>
        </head>
        """
        //        iframe {
        //            width: 100%;
        //            height: auto;
        //        }
        //        .wp-caption[style]{width:100% !important;height:auto;}
        //        .wp-caption-text{color:#7a7a7a;font-style:italic;-webkit-text-size-adjust:%ld%;}
        
        headHtml.append("<body>\(self)</body></html>")
        return headHtml
    }
}