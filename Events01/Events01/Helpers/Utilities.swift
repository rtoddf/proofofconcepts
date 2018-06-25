import UIKit

//func formatAttributedText(string:String, textSize:CGFloat, textColor:UIColor, linespacing: CGFloat) -> NSMutableAttributedString {
//    // *** Create instance of `NSMutableParagraphStyle`
//    let paragraphStyle = NSMutableParagraphStyle()
//    paragraphStyle.lineSpacing = linespacing  // Whatever line spacing you want in points
//    let font:UIFont = UIFont.systemFont(ofSize: textSize)
//    
//    let textAttributes: [NSAttributedStringKey: Any] = [
//        .paragraphStyle: paragraphStyle,
//        .font : font,
//        .foregroundColor: textColor
//    ]
//    
//    return NSMutableAttributedString(string: string + "\n", attributes: textAttributes)
//}

let group:String = "movies"

func getCategoryColor(group:String, category:String) -> String {
    var categoryColors: [String: String] = [:]
    
    // you need dawgnation ct colors
    
    if group == "events" {
        categoryColors = [
            "Art Galleries & Exhibits": "#222",
            "Comedy": "#baba71",
            "Festivals": "#ae0000",
            "Food & Wine": "#666",
            "Outdoors & Recreation": "#003264"
        ]
    }
    
    if group == "music" {
        categoryColors = [
            "Alternative": "#baba71",
            "Country": "#ae0000",
            "Hip Hop": "#f477c5",
            "Pop": "#f477c5",
            "Rock": "#003264"
        ]
    }
    
    if group == "places" {
        categoryColors = [
            "What To Do": "#f477c5"
        ]
    }
    
    guard let color = categoryColors[category] else { return "#999" }
    
    return color
}

func objectSizeToFit(label:UILabel) {
    let labelFixedWidth = label.frame.size.width
    label.sizeThatFits(CGSize(width: labelFixedWidth, height: CGFloat.greatestFiniteMagnitude))
    let newSize = label.sizeThatFits(CGSize(width: labelFixedWidth, height: CGFloat.greatestFiniteMagnitude))
    var newFrame = label.frame
    newFrame.size = CGSize(width: max(newSize.width, labelFixedWidth), height: newSize.height)
    label.frame = newFrame
    label.sizeToFit()
}

func createButton(title:String) -> UIButton {
    let button = UIButton()
    button.setTitle(title, for: .normal)
    button.setTitleColor(UIColor(hexString: "#ae0000"), for: .normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
    //    button.layer.borderWidth = 0.5
    //    button.layer.borderColor = UIColor(hexString: "#ae0000").cgColor
    return button
}

func printFonts() {
    let fontFamilyNames = UIFont.familyNames
    for familyName in fontFamilyNames {
        print("------------------------------")
        print("Font Family Name = [\(familyName)]")
        let names = UIFont.fontNames(forFamilyName: familyName)
        print("Font Names = [\(names)]")
    }
}
