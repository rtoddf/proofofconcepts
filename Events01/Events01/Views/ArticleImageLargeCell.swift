import UIKit

class ArticleImageLargeCell:BaseCell {
    var article:Article? {
        didSet {
            guard let leadMedia = article?.leadMedia?.path else { return }
            guard let categoryTitle = article?.category?.title else { return }
            guard let headline = article?.headline else { return }
            guard let summary = article?.summary else { return }
            guard let date = article?.date else { return }
//            guard let creator = article?.creator?.name else { return }
            
            leadImageView.loadImageUsingUrlString(imageUrl: leadMedia)
            headlineLabel.text = headline
            
            objectSizeToFit(label: headlineLabel)
            // send a noticication back to the cell to resize
            notificationCenter.post(name: .UpdateLargeStoryCellHeadlineHeight,
                                    object: headlineLabel.frame.height)
            
            categoryLabel.text = categoryTitle.uppercased()
            categoryLabel.textColor = UIColor(hexString: getCategoryColor(group: group, category: categoryTitle))

            let attributedText = NSMutableAttributedString(string: summary, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 13), NSAttributedStringKey.foregroundColor: UIColor(hexString: "#333") as Any])
            textLabel.attributedText = attributedText
            detailsLabel.text = date.timeAgoDisplay()
            
//            creatorLabel.text = creator

//            if categoryTitle.isEmpty {
//                notificationCenter.post(name: .UpdateCategoryCellHeight,
//                                        object: 18)
//
//                addConstraintsWithFormat(format: "V:|[v0(200)][v1(0)][v2(70)]", views: leadImageView, categoryLabel, leadArticleInfoView)
//            }
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    let categoryLabel:UILabel = {
        let label = UILabel()
        label.font = .articleCategoryFont
        label.textColor = UIColor(hexString: "#000")
        return label
    }()
    
    let headlineLabel:UILabel = {
        let label = UILabel()
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
    
//    let creatorLabel:UILabel = {
//        let label = UILabel()
//        label.font = .labelFont
//        label.textColor = UIColor(hexString: "#fff")
//        return label
//    }()

//    let userInteractionStackView:UIStackView = {
//        let stackView = UIStackView()
//        stackView.distribution = .fillEqually
//
//        let shareButton = createButton(title: "Share")
//        let saveButton = createButton(title: "Save")
//        let favoriteButton = createButton(title: "Fave")
//        stackView.addArrangedSubview(shareButton)
//        stackView.addArrangedSubview(saveButton)
//        stackView.addArrangedSubview(favoriteButton)
//
//        return stackView
//    }()

    override func setupViews(){
        addSubview(leadImageView)
        addSubview(categoryLabel)
        addSubview(headlineLabel)
        addSubview(textLabel)
        addSubview(detailsLabel)

//        leadArticleInfoView.addSubview(creatorLabel)
        
        headlineLabel.frame = CGRect(x: 14, y: 14, width: frame.width - 28, height: 200)
        
        let imageWidth = frame.width
        let imageHeight = (9 / 16) * imageWidth
        
        addConstraintsWithFormat(format: "H:|-12-[v0]-12-|", views: leadImageView)
        addConstraintsWithFormat(format: "H:|-12-[v0]-12-|", views: categoryLabel)
        addConstraintsWithFormat(format: "H:|-12-[v0]-12-|", views: headlineLabel)
        addConstraintsWithFormat(format: "H:|-12-[v0]-12-|", views: textLabel)
        addConstraintsWithFormat(format: "H:|-12-[v0]-12-|", views: detailsLabel)
        
        addConstraintsWithFormat(format: "V:|-12-[v0(\(imageHeight))]-4-[v1]-2-[v2]-2-[v3]-4-[v4]", views: leadImageView, categoryLabel, headlineLabel, textLabel, detailsLabel)
    }
}

class BaseCell:UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
    }
}
