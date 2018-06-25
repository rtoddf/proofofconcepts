import UIKit

class ArticleImageTopCell:BaseCell {
    var item:Item? {
        didSet {
            guard let parentId = item?.parentId else { return }
            guard let headline = item?.headline else { return }
            guard let date = item?.date else { return }
            guard let startTime = item?.startTime else { return }
            guard let endTime = item?.endTime else { return }
            guard let venueName = item?.venueName else { return }
            guard let parentCategoryName = item?.parentCategoryName else { return }
            
            leadImageView.loadPointsLocalImageUsingParentId(imageId: parentId)
            categoryLabel.text = parentCategoryName
            categoryLabel.textColor = UIColor(hexString: getCategoryColor(group: group, category: parentCategoryName))
            headlineLabel.text = headline
            detailsLabel.text = date + "\n" + startTime + "-" + endTime + "\n" + venueName
        }
    }
    
    let leadImageView:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.backgroundColor = UIColor(hexString: "#333")
        iv.layer.borderWidth = 0.5
        iv.layer.borderColor = UIColor(hexString: "#333")?.cgColor
        return iv
    }()
    
    let categoryLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hexString: "#000")
        label.font = .boldLabelFont
        
        return label
    }()
    
    let headlineLabel:UILabel = {
        let label = UILabel()
        label.font = .eventHeadlineFont
        label.numberOfLines = 3
        return label
    }()
    
    let detailsLabel:UILabel = {
        let label = UILabel()
        label.font = .eventDetailsFont
        label.textColor = UIColor(hexString: "#666")
        label.numberOfLines = 4
        return label
    }()
    
    override func setupViews() {
        addSubview(categoryLabel)
        addSubview(leadImageView)
        addSubview(headlineLabel)
        addSubview(detailsLabel)
        
        let imageWidth = frame.width
        let imageHeight = (9 / 16) * imageWidth
        
        addConstraintsWithFormat(format: "H:|-12-[v0]-12-|", views: categoryLabel)
        addConstraintsWithFormat(format: "H:|-12-[v0]-12-|", views: leadImageView)
        addConstraintsWithFormat(format: "H:|-12-[v0]-12-|", views: headlineLabel)
        addConstraintsWithFormat(format: "H:|-12-[v0]-12-|", views: detailsLabel)
        addConstraintsWithFormat(format: "V:|[v0(\(imageHeight))]-2-[v1]-2-[v2]-4-[v3]", views: leadImageView, categoryLabel, headlineLabel, detailsLabel)
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
    
    func setupViews(){
        
    }
}
