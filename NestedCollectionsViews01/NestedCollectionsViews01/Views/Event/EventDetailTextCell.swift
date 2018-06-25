import UIKit

class EventDetailTextCell:BaseCell {
    var event:Event? {
        didSet {
            guard let fullText = event?.fullText else { return }
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 5
            
            let textAttributes: [NSAttributedStringKey: Any] = [
                .paragraphStyle: paragraphStyle,
                .font : UIFont.systemFont(ofSize: 14),
                .foregroundColor: UIColor(hexString: "#777777")
            ]
            
            let rawHTML = Data(fullText.utf8)
            guard let attributedString = try? NSMutableAttributedString(data: rawHTML, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) else { return }
            let attributedText = NSMutableAttributedString(string: attributedString.string, attributes: textAttributes)
            // add the styled attributed text to the textView
            textView.attributedText = attributedText
            
            let textViewRect = NSString(string: attributedText.string).boundingRect(with: CGSize(width:frame.width - 28, height:.infinity), options: NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin), attributes: textAttributes, context: nil)
            
            // resize the textView with the new height
            textView.frame = CGRect(x: 14, y: 14, width: frame.width - 28, height: textViewRect.height + CGFloat(76))
            textView.sizeToFit()
            
            // send a noticication back to the cell to resize
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UpdateEventTextHeight"), object: textViewRect.height + CGFloat(76))
        }
    }
    
    let textView:UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.contentInset = UIEdgeInsetsMake(0, -5, 0, 0)
        textView.isSelectable = false
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    override func setupViews() {
        addSubview(textView)
        textView.frame = CGRect(x: 14, y: 14, width: frame.width - 28, height: 200)
    }
}
