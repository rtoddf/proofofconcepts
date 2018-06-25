import UIKit

class ArticleImageLeftCell:BaseCell {
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
            headlineLabel.text = headline
            categoryLabel.text = parentCategoryName
            detailsLabel.text = date + "\n" + startTime + "-" + endTime + "\n" + venueName

            categoryLabel.textColor = UIColor(hexString: getCategoryColor(group: group, category: parentCategoryName))
        }
    }

    let headlineLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .eventHeadlineFont
        label.textColor = UIColor(hexString: "#222")
        label.numberOfLines = 3
        return label
    }()
    
    let detailsLabel:UILabel = {
        let label = UILabel()
        label.font = .eventDetailsFont
        label.textColor = UIColor(hexString: "#666")
        label.numberOfLines = 3
        return label
    }()
    
    let leadImageView:UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = UIColor(hexString: "#333")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.borderWidth = 0.5
        iv.layer.borderColor = UIColor(hexString: "#333")?.cgColor
        return iv
    }()
    
    let categoryLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.textColor = UIColor(hexString: "#000")
        return label
    }()
    
    let detailView:UIView = {
        let view = UIView()
        return view
    }()
    
    let dividerView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#999")
        return view
    }()
    
    override func setupViews() {
        addSubview(leadImageView)
        addSubview(detailView)
        
        detailView.addSubview(headlineLabel)
        detailView.addSubview(detailsLabel)
        detailView.addSubview(categoryLabel)
        
        addConstraintsWithFormat(format: "H:|-12-[v0(\(frame.width / 3))]-12-[v1]-12-|", views: leadImageView, detailView)
        addConstraintsWithFormat(format: "V:|[v0]-12-|", views: detailView)
        addConstraintsWithFormat(format: "V:|[v0]-12-|", views: leadImageView)
        
        addConstraintsWithFormat(format: "H:|-2-[v0]-2-|", views: categoryLabel)
        addConstraintsWithFormat(format: "H:|-2-[v0]-2-|", views: headlineLabel)
        addConstraintsWithFormat(format: "H:|-2-[v0]-2-|", views: detailsLabel)
        addConstraintsWithFormat(format: "V:|[v0]-2-[v1]-4-[v2]", views: categoryLabel, headlineLabel, detailsLabel)
    }

}
