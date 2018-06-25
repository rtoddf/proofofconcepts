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
