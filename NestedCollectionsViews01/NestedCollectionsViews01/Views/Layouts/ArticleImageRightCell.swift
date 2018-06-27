import UIKit

class ArticleImageRightCell:BaseCell {
    var article:Article? {
        didSet {
            guard let leadMedia = article?.leadMedia?.path else { return }
            guard let headline = article?.headline else { return }
            guard let summary = article?.summary else { return }
            guard let date = article?.date else { return }
            
            leadImageView.loadImageUsingUrlString(imageUrl: leadMedia)
            headlineLabel.text = headline
            detailsLabel.text = date.timeAgoDisplay()
            let attributedText = NSMutableAttributedString(string: summary, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 13), NSAttributedStringKey.foregroundColor: UIColor(hexString: "#333") as Any])
            textLabel.attributedText = attributedText
            detailsLabel.text = date.timeAgoDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let leadImageView:CustomImageView = {
        let iv = CustomImageView()
        iv.backgroundColor = UIColor(hexString: "#999")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.borderWidth = 0.5
        iv.backgroundColor = UIColor(hexString: "#333")
        iv.layer.borderColor = UIColor(hexString: "#333")?.cgColor
        return iv
    }()

    let headlineLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .headlineFont
        label.textColor = UIColor(hexString: "#222")
        label.numberOfLines = 2
        return label
    }()
    
    let detailView:UIView = {
        let view = UIView()
        return view
    }()
    
    let detailsLabel:UILabel = {
        let label = UILabel()
        label.font = .detailsFont
        label.textColor = UIColor(hexString: "#666")
        label.numberOfLines = 3
        return label
    }()
    
    let textLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = .bodyFont
        label.textColor = UIColor(hexString: "#222")
        return label
    }()
    
    override func setupViews() {
        addSubview(leadImageView)
        addSubview(detailView)
        
        detailView.addSubview(headlineLabel)
        detailView.addSubview(detailsLabel)
        detailView.addSubview(textLabel)
        
        addConstraintsWithFormat(format: "H:|-12-[v0]-12-[v1(\(frame.width / 3))]-12-|", views: detailView, leadImageView)
        addConstraintsWithFormat(format: "V:|[v0]-12-|", views: leadImageView)
        addConstraintsWithFormat(format: "V:|[v0]-12-|", views: detailView)
        
        addConstraintsWithFormat(format: "H:|-2-[v0]-2-|", views: headlineLabel)
        addConstraintsWithFormat(format: "H:|-2-[v0]-2-|", views: detailsLabel)
        addConstraintsWithFormat(format: "H:|-2-[v0]-2-|", views: textLabel)
        addConstraintsWithFormat(format: "V:|[v0]-2-[v1]-2-[v2]", views: headlineLabel, detailsLabel, textLabel)
    }
    
}
