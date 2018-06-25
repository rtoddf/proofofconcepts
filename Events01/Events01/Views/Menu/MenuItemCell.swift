import UIKit

class MenuItemCell:BaseCell {
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor.darkGray : UIColor.white
        }
    }
    
    var setting:MenuItem? {
        didSet {
            nameLabel.text = setting?.name
        }
    }
    
    let nameLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let bottomBorderView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#777")
        return view
    }()
    
    override func setupViews() {
        super.setupViews()
        
        backgroundColor = UIColor(hexString: "#fff")
        
        addSubview(nameLabel)
        addSubview(bottomBorderView)
        
        addConstraintsWithFormat(format: "H:|-8-[v0]|", views: nameLabel)
        addConstraintsWithFormat(format: "H:|[v0]|", views: bottomBorderView)
        addConstraintsWithFormat(format: "V:|[v0(49.5)]-[v1(0.5)]|", views: nameLabel, bottomBorderView)
    }
    
}

// extra code
//            nameLabel.textColor = isHighlighted ? UIColor.white : UIColor.black
//            iconImageView.tintColor = isHighlighted ? UIColor.white : UIColor.darkGray
//            print(isHighlighted)

//            guard let imageName = setting?.imageName else { return }
//            iconImageView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
//            iconImageView.tintColor = UIColor.darkGray

//    let iconImageView:UIImageView  = {
//        let iv = UIImageView()
//        iv.contentMode = .scaleAspectFill
//        return iv
//    }()

//        addSubview(iconImageView)
//        addConstraintsWithFormat(format: "V:|-8-[v0(30)]-8-|", views: iconImageView)

//        addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
