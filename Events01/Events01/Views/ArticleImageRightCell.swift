import UIKit

class ArticleImageRightCell:BaseCell {
    var article:Article? {
        didSet {
            guard let leadImage = article?.leadMedia?.path else { return }
            guard let categoryTitle = article?.category?.title else { return }
            guard let headline = article?.headline else { return }
            guard let date = article?.date else { return }
            guard let summary = article?.summary else { return }
            
            leadImageView.loadImageUsingUrlString(imageUrl: leadImage)
            categoryLabel.text = categoryTitle.uppercased()
            categoryLabel.textColor = UIColor(hexString: getCategoryColor(group: group, category: categoryTitle))
            headlineLabel.text = headline
            detailsLabel.text = date.timeAgoDisplay()
            
            let attributedText = NSMutableAttributedString(string: summary, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 13), NSAttributedStringKey.foregroundColor: UIColor(hexString: "#333") as Any])
            textLabel.attributedText = attributedText
        }
    }
    
    let leadImageView:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.borderWidth = 0.5
        iv.backgroundColor = UIColor(hexString: "#333")
        iv.layer.borderColor = UIColor(hexString: "#333")?.cgColor
        return iv
    }()
    
    let detailView:UIView = {
        let view = UIView()
        return view
    }()
    
    let categoryLabel:UILabel = {
        let label = UILabel()
        label.font = .articleCategoryFont
        label.textColor = UIColor(hexString: "#000")
        return label
    }()
    
    let headlineLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .articleHeadlineFont
        label.textColor = UIColor(hexString: "#222")
        label.numberOfLines = 2
        return label
    }()
    
    let textLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = .articleBodyFont
        label.textColor = UIColor(hexString: "#222")
        return label
    }()
    
    let detailsLabel:UILabel = {
        let label = UILabel()
        label.font = .articleDetailsFont
        label.textColor = UIColor(hexString: "#666")
        label.numberOfLines = 3
        return label
    }()
    
    override func setupViews() {
        addSubview(leadImageView)
        addSubview(detailView)
        
        detailView.addSubview(categoryLabel)
        detailView.addSubview(headlineLabel)
        detailView.addSubview(textLabel)
        detailView.addSubview(detailsLabel)
        
        addConstraintsWithFormat(format: "H:|-12-[v0]-12-[v1(\(frame.width / 3))]-12-|", views: detailView, leadImageView)
        addConstraintsWithFormat(format: "V:|[v0]-12-|", views: leadImageView)
        addConstraintsWithFormat(format: "V:|[v0]-12-|", views: detailView)
        
        addConstraintsWithFormat(format: "H:|-2-[v0]-2-|", views: categoryLabel)
        addConstraintsWithFormat(format: "H:|-2-[v0]-2-|", views: headlineLabel)
        addConstraintsWithFormat(format: "H:|-2-[v0]-2-|", views: textLabel)
        addConstraintsWithFormat(format: "H:|-2-[v0]-2-|", views: detailsLabel)
        
        addConstraintsWithFormat(format: "V:|[v0]-2-[v1]-2-[v2]-2-[v3]", views: categoryLabel, headlineLabel, textLabel, detailsLabel)
    }
    
}
