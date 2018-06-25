import UIKit

class ItemDetailHeaderCell:BaseCell {
    var item:Item? {
        didSet {
            guard let parentId = item?.parentId else { return }
            guard let headline = item?.headline else { return }
            guard let date = item?.date else { return }
            guard let startTime = item?.startTime else { return }
            guard let endTime = item?.endTime else { return }
            guard let venueName = item?.venueName else { return }
            guard let venueAddress = item?.venueAddress else { return }
            
            guard let parentCategoryName = item?.parentCategoryName else { return }
            
            imageView.loadPointsLocalImageUsingParentId(imageId: parentId)
            titleLabel.text = headline
            detailsLabel.text = date + " | " + startTime + "-" + endTime + "\n" + venueName + "\n" + venueAddress
        }
    }
    
    let imageView:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = UIColor(hexString: "#333333")
        return iv
    }()
    
    let titleLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 3
        return label
    }()
    
    let detailsLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor(hexString: "#777777")
        label.numberOfLines = 4
        return label
    }()
    
    override func setupViews() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(detailsLabel)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: imageView)
        addConstraintsWithFormat(format: "H:|-14-[v0]-14-|", views: titleLabel)
        addConstraintsWithFormat(format: "H:|-14-[v0]-14-|", views: detailsLabel)
        addConstraintsWithFormat(format: "V:|[v0(\((9 / 16) * frame.width))]-8-[v1]-8-[v2]", views: imageView, titleLabel, detailsLabel)
    }
    
}
