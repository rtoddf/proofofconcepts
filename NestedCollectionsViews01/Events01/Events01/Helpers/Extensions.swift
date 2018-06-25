import UIKit

// don't leave this hanging
let notificationCenter = NotificationCenter.default

extension Notification.Name {
    static let UpdateLargeStoryCellHeadlineHeight = Notification.Name(rawValue: "UpdateLargeStoryCellHeadlineHeight")
    static let UpdateCategoryCellHeight = Notification.Name(rawValue: "UpdateCategoryCellHeight")
    static let UpdateImageCaptionHeight = Notification.Name(rawValue: "UpdateImageCaptionHeight")
    static let UpdateHeadlineHeight = Notification.Name(rawValue: "UpdateHeadlineHeight")
    static let UpdateArticleHeight = Notification.Name(rawValue: "UpdateArticleHeight")
}

extension UIViewController {
//    func setupNavBarButtons() {
//        // imaged for UIBarButtonItems must me at size
//        let searchBarButtonItem = UIBarButtonItem(image: UIImage(named: "search")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleSearch))
//        let menuButtonItem = UIBarButtonItem(image: UIImage(named: "bars")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(showMenu))
//        navigationItem.leftBarButtonItems = [menuButtonItem]
//        navigationItem.rightBarButtonItems = [searchBarButtonItem]
//    }
}

extension UIView {
    func addConstraintsWithFormat(format:String, views:UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}

// https://gist.github.com/haversnail/5dc4c016c0678e1e4060a31a081d814c
extension UIColor {
    /**
     Initializes and returns a color object using the specified opacity and hexidecimal color code.
     
     - Parameters:
     - hexString: The RGB value of the color object, represented as a hexidecimal string. This value may include all six hexidecimal digits, or an abbreviated, three-digit shorthand form, and may optionally contain a preceeding number sign (`#`). Any other values will result in a failed initialization.
     - alpha:     The opacity value of the color object, specified as a value from 0.0 to 1.0. Alpha values below 0.0 are interpreted as 0.0, and values above 1.0 are interpreted as 1.0. **The default value is 1.0.**
     
     - Returns: The color object, if one could be initialized from the given `hexString`, or `nil` otherwise. The color information represented by this object is in the same RGB colorspace assigned by the [init(red:green:blue:alpha:)](apple-reference-documentation://hs-s777Fe4) initializer.
     */
    public convenience init?(hexString: String, alpha: CGFloat = 1.0) {
        
        // Check for the right characters in the string parameter:
        guard let regex = try? NSRegularExpression(pattern: "^#?[0-9a-fA-F]{3,6}") else { return nil }
        guard regex.numberOfMatches(in: hexString, range: NSMakeRange(0, hexString.count)) == 1 else { return nil } // print("hexString parameter does not meet prerequisites.")
        
        // Get the string value without the pound symbol:
        let hex = hexString.hasPrefix("#") ? hexString.trimmingCharacters(in: ["#"]) : hexString
        
        var isShorthand: Bool // Used to indicate whether there are only three characters used in the hex string.
        switch hex.count {
        case 3: isShorthand = true
        case 6: isShorthand = false
        default: return nil // print("Cannot parse hexString: parameter value must contain exactly three or six hexidecimal digits.")
        }
        
        let offset = isShorthand ? 1 : 2 // Get the right character(s) in the hex string depending on whether shorthand is used.
        let rIndex = hex.index(hex.startIndex, offsetBy: offset)
        let gIndex = hex.index(hex.startIndex, offsetBy: offset * 2)
        let bIndex = hex.index(hex.startIndex, offsetBy: offset * 3)
        
        let count = isShorthand ? 2 : 1 // Duplicate the hex value's character if shorthand is used.
        let rStr = String(repeating: String(hex[hex.startIndex..<rIndex]), count: count)
        let gStr = String(repeating: String(hex[rIndex..<gIndex]), count: count)
        let bStr = String(repeating: String(hex[gIndex..<bIndex]), count: count)
        
        let r = UInt8(rStr, radix: 16)
        let g = UInt8(gStr, radix: 16)
        let b = UInt8(bStr, radix: 16)
        
        guard r != nil, b != nil, g != nil else { return nil } // print("Unable to convert hex string values to 8-bit unsigned integer values.")
        
        self.init(red: CGFloat(r!) / 255, green: CGFloat(g!) / 255, blue: CGFloat(b!) / 255, alpha: alpha)
    }
}

extension UIImageView {
    func loadImageUsingUrlString(imageUrl:String) {
        let imageNameSplit = imageUrl.components(separatedBy: "/")
        let savedImageName = imageNameSplit.last
        
        // fix the bang!!!
        guard let url = URL(string: imageUrl) else { return }
        let request = NSMutableURLRequest(url: url)

        // restores from memory if downloaded
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        if documentsPath.count > 0 {
            let documentsDirectory = documentsPath[0]
            guard let savedImageName = savedImageName else { return }
            
            let restorePath = documentsDirectory + savedImageName
            self.image = UIImage(contentsOfFile: restorePath)
        }
        
        // downloads the image the first time
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            if error != nil {
                print(error as Any)
            } else {
                guard let data = data else { return }
                guard let image = UIImage(data: data) else { return }
                
                DispatchQueue.main.async { // Correct - https://developer.apple.com/documentation/code_diagnostics/main_thread_checker
                    self.image = image
                    
                    // searches for documents path
                    let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
                    // should return one, but we just make sure
                    if documentsPath.count > 0 {
                        guard let savedImageName = savedImageName else { return }
                        
                        let documentsDirectory = documentsPath[0]
                        let savePath = documentsDirectory + savedImageName
                        
                        do {
                            try UIImageJPEGRepresentation(image, 1)?.write(to: URL(fileURLWithPath: savePath))
                        } catch {
                            // process the error
                        }
                        
                        // another way
                        // FileManager.default.createFile(atPath: savePath, contents: data, attributes: nil)
                    }
                }
                
            }
        }
        task.resume()
    }
}

extension NSMutableAttributedString {
    @discardableResult func format(string:String, font:String, textSize:CGFloat, textColor:UIColor, linespacing: CGFloat) -> NSMutableAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = linespacing  // Whatever line spacing you want in points
        let font:UIFont = (UIFont(name: font, size: textSize))!
        
        let attrs: [NSAttributedStringKey: Any] = [
            .paragraphStyle: paragraphStyle,
            .font : font,
            .foregroundColor: textColor
        ]
        
        let boldString = NSMutableAttributedString(string: string, attributes: attrs)
        append(boldString)
        
        return self
    }
}

class InsetLabel: UILabel {
    var topInset = CGFloat(3)
    var bottomInset = CGFloat(3)
    var leftInset = CGFloat(8)
    var rightInset = CGFloat(8)
    
    override func drawText(in rect: CGRect) {
        let insets: UIEdgeInsets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
    }
    
    override public var intrinsicContentSize: CGSize {
        var intrinsicSuperViewContentSize = super.intrinsicContentSize
        intrinsicSuperViewContentSize.height += topInset + bottomInset
        intrinsicSuperViewContentSize.width += leftInset + rightInset
        return intrinsicSuperViewContentSize
    }
}
