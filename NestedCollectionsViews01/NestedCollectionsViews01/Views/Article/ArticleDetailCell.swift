import UIKit

class ArticleDetailCell:BaseCell {    
    var article:Article? {
        didSet {
            guard let leadMedia = article?.leadMedia?.path else { return }
            guard let leadMediaCaption = article?.leadMedia?.caption else { return }
            guard let leadMediaCredit = article?.leadMedia?.credit else { return }
            guard let date = article?.date else { return }
            guard let headline = article?.headline else { return }
            guard let creatorImage = article?.creator?.image else { return }
            guard let creator = article?.creator?.name else { return }
            guard let creatorTitle = article?.creator?.title else { return }
            
            leadMediaView.loadImageUsingUrlString(imageUrl: leadMedia)
            leadMediaCaptionLabel.text = leadMediaCaption + " " + leadMediaCredit
            objectSizeToFit(label: leadMediaCaptionLabel)
            
            headlineLabel.text = headline
            objectSizeToFit(label: headlineLabel)
            var headlineReturnedHeight:CGFloat = headlineLabel.frame.height + 6
            
            var authorText = "By "
            authorText.append("\(creator)")
            if !creatorTitle.isEmpty {
                authorText.append(", \(creatorTitle)")
            }
            authorText.append("\n\(date.toDateString(inputDateFormat: "E, dd MMM yyyy HH:mm:ss z", ouputDateFormat: "MMMM dd, YYYY"))")
            creatorImageView.loadImageUsingUrlString(imageUrl: creatorImage)
            creatorLabel.text = authorText
            
            if creatorImage.isEmpty {
                addConstraintsWithFormat(format: "H:|-14-[v0]-14-|", views: creatorLabel)
            }
            
            if !creatorImage.isEmpty {
                headlineReturnedHeight = headlineLabel.frame.height + 12
            }
            
            // send a noticication back to the cell to resize
            notificationCenter.post(name: .UpdateImageCaptionHeight,
                                    object: leadMediaCaptionLabel.frame.height)
            
            notificationCenter.post(name: .UpdateHeadlineHeight,
                                    object: headlineReturnedHeight)
            
            // reset constraints with new values
            addConstraintsWithFormat(format: "V:|[v0(\((9 / 16) * frame.width))]-4-[v1(\(leadMediaCaptionLabel.frame.height))]-8-[v2(\(headlineLabel.frame.height))]-8-[v3(50)]", views: leadMediaView, leadMediaInfoView, headlineLabel, creatorImageView)
            
        }
    }
    
    let leadMediaView:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    let leadMediaInfoView:UIView = {
        let view = UIView()
        return view
    }()
    
    let leadMediaCaptionLabel:UILabel = {
        let label = UILabel()
        label.font = .labelFont
        label.textColor = UIColor(hexString: "#666")
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        return label
    }()
    
    let headlineLabel:UILabel = {
        let label = UILabel()
        label.font = .articleTitleFont
        label.numberOfLines = 4
        return label
    }()
    
    let creatorLabel:UILabel = {
        let label = UILabel()
        label.font = .labelFont
        label.textColor = UIColor(hexString: "#000")
        label.numberOfLines = 2
        return label
    }()
    
    let creatorImageView:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    override func setupViews() {
        addSubview(leadMediaView)
        addSubview(leadMediaInfoView)
        
        leadMediaInfoView.addSubview(leadMediaCaptionLabel)
        
        addSubview(headlineLabel)
        addSubview(creatorLabel)
        addSubview(creatorImageView)
        
        let imageWidth = frame.width
        let imageHeight = (9 / 16) * imageWidth
        
        // dynamic height start
        headlineLabel.frame = CGRect(x: 14, y: 14, width: frame.width - 28, height: 200)
        leadMediaCaptionLabel.frame = CGRect(x: 14, y: 14, width: frame.width - 28, height: 200)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: leadMediaView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: leadMediaInfoView)
        addConstraintsWithFormat(format: "H:|-14-[v0]-14-|", views: headlineLabel)
        addConstraintsWithFormat(format: "H:|-14-[v0(50)]-8-[v1]-14-|", views: creatorImageView, creatorLabel)
        addConstraintsWithFormat(format: "V:|[v0(\(imageHeight))]-4-[v1(35)]-8-[v2]-8-[v3(50)]", views: leadMediaView, leadMediaInfoView, headlineLabel, creatorImageView)
        
        leadMediaInfoView.addConstraintsWithFormat(format: "H:|-14-[v0]-14-|", views: leadMediaCaptionLabel)
        leadMediaInfoView.addConstraintsWithFormat(format: "V:|[v0]|", views: leadMediaCaptionLabel)
        
        addConstraint(NSLayoutConstraint(item: creatorLabel,  attribute: .top, relatedBy: .equal, toItem: creatorImageView, attribute: .top, multiplier: 1, constant: 0))
    }
}
