import UIKit

class ArticleImageLargeCell:BaseCell {
    var item:Item? {
        didSet {
            guard let parentId = item?.parentId else { return }
            guard let headline = item?.headline else { return }
            guard let date = item?.date else { return }
            guard let startTime = item?.startTime else { return }
//            guard let endTime = item?.endTime else { return }
            guard let venueName = item?.venueName else { return }
            guard let parentCategoryName = item?.parentCategoryName else { return }
            
            guard let fullText = item?.fullText else { return }
            
            leadImageView.loadPointsLocalImageUsingParentId(imageId: parentId)
            headlineLabel.text = headline
            categoryLabel.text = parentCategoryName
            categoryLabel.textColor = UIColor(hexString: getCategoryColor(group: group, category: parentCategoryName))
            detailsLabel.text = date + ", " + startTime + " @ " + venueName

            guard let summaryText = fullText.htmlAttributedString else { return }
            textLabel.text = summaryText.string
        }
    }

    let leadImageView:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = UIColor(hexString: "#333")
        iv.layer.borderWidth = 0.5
        iv.layer.borderColor = UIColor(hexString: "#333")?.cgColor
        return iv
    }()
    
    let categoryLabel:UILabel = {
        let label = UILabel()
        label.font = .boldLabelFont
        label.textColor = UIColor(hexString: "#000")
        return label
    }()
    
    let headlineLabel:UILabel = {
        let label = UILabel()
        label.font = .eventHeadlineFont
        label.numberOfLines = 2
        label.textColor = UIColor(hexString: "#000")
        return label
    }()
    
    let textLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .eventBodyFont
        label.textColor = UIColor(hexString: "#222")
        return label
    }()
    
    let detailsLabel:UILabel = {
        let label = UILabel()
        label.font = .eventDetailsFont
        label.textColor = UIColor(hexString: "#666")
        label.numberOfLines = 4
        return label
    }()
    
    override func setupViews(){
        addSubview(leadImageView)
        addSubview(categoryLabel)
        addSubview(headlineLabel)
        addSubview(detailsLabel)
        addSubview(textLabel)

        let imageWidth = frame.width
        let imageHeight = (9 / 16) * imageWidth
        
        addConstraintsWithFormat(format: "H:|-12-[v0]-12-|", views: leadImageView)
        addConstraintsWithFormat(format: "H:|-12-[v0]-12-|", views: categoryLabel)
        addConstraintsWithFormat(format: "H:|-12-[v0]-12-|", views: headlineLabel)
        addConstraintsWithFormat(format: "H:|-12-[v0]-12-|", views: detailsLabel)
        addConstraintsWithFormat(format: "H:|-12-[v0]-12-|", views: textLabel)
        
        addConstraintsWithFormat(format: "V:|-12-[v0(\(imageHeight))]-4-[v1]-2-[v2]-2-[v3]-4-[v4]", views: leadImageView, categoryLabel, headlineLabel, textLabel, detailsLabel)
        
    }

}
