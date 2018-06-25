import UIKit

class ArticleDetailTextCell:BaseCell {
    var article:Article? {
        didSet {
            guard let fullText = article?.fullText else { return }

            let fixedWidth = textView.frame.size.width
            let wrappedHTML = fullText.wrapHTML(width: fixedWidth)
            textView.attributedText = wrappedHTML.convertHtml()

            textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
            let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
            var newFrame = textView.frame
            newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
            textView.frame = newFrame
            textView.sizeToFit()
            
            // send a noticication back to the cell to resize
            notificationCenter.post(name: .UpdateArticleHeight,
                                    object: textView.frame.height)
        }
    }
    
    let textView:UITextView = {
        let textView = UITextView()
        textView.font = .bodyFont
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
