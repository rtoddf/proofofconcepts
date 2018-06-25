import UIKit

class ArticleImageTopCell:BaseCell {
    var article:Article? {
        didSet {
            guard let leadImage = article?.leadMedia?.path else { return }
            guard let categoryTitle = article?.category?.title else { return }
            guard let headline = article?.headline else { return }
            guard let summary = article?.summary else { return }
            guard let date = article?.date else { return }
            
            leadImageView.loadImageUsingUrlString(imageUrl: leadImage)
            categoryLabel.text = categoryTitle.uppercased()
            categoryLabel.textColor = UIColor(hexString: getCategoryColor(group: group, category: categoryTitle))
            headlineLabel.text = headline
            
            let attributedText = NSMutableAttributedString(string: summary, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 13), NSAttributedStringKey.foregroundColor: UIColor(hexString: "#333") as Any])
            textLabel.attributedText = attributedText
            
            detailsLabel.text = date.timeAgoDisplay()
        }
    }
    
    let leadImageView:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = UIColor(hexString: "#333333")
        iv.layer.borderWidth = 0.5
        iv.layer.borderColor = UIColor(hexString: "#333")?.cgColor
        return iv
    }()

    let categoryLabel:UILabel = {
        let label = UILabel()
        label.font = .articleCategoryFont
        label.textColor = UIColor(hexString: "#000")
        return label
    }()

    let headlineLabel:UILabel = {
        let label = UILabel()
        label.font = .titleFont
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
        addSubview(categoryLabel)
        addSubview(leadImageView)
        addSubview(headlineLabel)
        addSubview(textLabel)
        addSubview(detailsLabel)

        let imageWidth = frame.width
        let imageHeight = (9 / 16) * imageWidth

        addConstraintsWithFormat(format: "H:|-12-[v0]-12-|", views: categoryLabel)
        addConstraintsWithFormat(format: "H:|-12-[v0]-12-|", views: leadImageView)
        addConstraintsWithFormat(format: "H:|-12-[v0]-12-|", views: headlineLabel)
        addConstraintsWithFormat(format: "H:|-12-[v0]-12-|", views: textLabel)
        addConstraintsWithFormat(format: "H:|-12-[v0]-12-|", views: detailsLabel)
        

        addConstraintsWithFormat(format: "V:|[v0(\(imageHeight))]-2-[v1]-2-[v2]-2-[v3]-2-[v4]", views: leadImageView, categoryLabel, headlineLabel, textLabel, detailsLabel)
    }
}
