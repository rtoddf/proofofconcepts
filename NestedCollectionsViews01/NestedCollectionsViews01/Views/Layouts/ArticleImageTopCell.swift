import UIKit

class ArticleImageTopCell:BaseCell {
    var event:Event? {
        didSet {
            guard let parentId = event?.parentId else { return }
            guard let headline = event?.headline else { return }
            guard let date = event?.date else { return }
            guard let startTime = event?.startTime else { return }
            //            guard let endTime = event?.endTime else { return }
            guard let venueName = event?.venueName else { return }
            guard let parentCategoryName = event?.parentCategoryName else { return }
            
            guard let fullText = event?.fullText else { return }
            
            leadImageView.loadPointsLocalImageUsingParentId(imageId: parentId)
            headlineLabel.text = headline
            detailsLabel.text = date + ", " + startTime + " @ " + venueName
            
            guard let summaryText = fullText.htmlAttributedString else { return }
            textLabel.text = summaryText.string
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
        iv.backgroundColor = UIColor(hexString: "#333333")
        iv.layer.borderWidth = 0.5
        iv.layer.borderColor = UIColor(hexString: "#333")?.cgColor
        return iv
    }()
    
    let headlineLabel:UILabel = {
        let label = UILabel()
        label.font = .headlineFont
        label.numberOfLines = 2
        return label
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
        addSubview(headlineLabel)
        addSubview(detailsLabel)
        addSubview(textLabel)
        
        let imageWidth = frame.width
        let imageHeight = (9 / 16) * imageWidth
        
        addConstraintsWithFormat(format: "H:|-12-[v0]-12-|", views: leadImageView)
        addConstraintsWithFormat(format: "H:|-12-[v0]-12-|", views: headlineLabel)
        addConstraintsWithFormat(format: "H:|-12-[v0]-12-|", views: textLabel)
        addConstraintsWithFormat(format: "H:|-12-[v0]-12-|", views: detailsLabel)
        addConstraintsWithFormat(format: "V:|[v0(\(imageHeight))]-2-[v1]-2-[v2]-2-[v3]", views: leadImageView, headlineLabel, detailsLabel, textLabel)
    }
}
