import UIKit

class CurrentConditionsCell:BaseCell {
    
    var city:City? {
        didSet {
            guard let name = city?.name else { return }
            guard let state = city?.stateAbbreviation else { return }
            
            cityLabel.text = name + ", " + state + " Weather"
        }
    }
    
    var currentConditions:CurrentConditions? {
        didSet {
            guard let tempf = currentConditions?.tempF else { return }
            guard let sky = currentConditions?.sky else { return }
            tempLabel.text = String(tempf) + "°"
            skyLabel.text = sky
        }
    }
    
    let cityLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor(hexString: "#fff")
        label.font = .articleHeadlineFont
        return label
    }()
    
    let tempLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor(hexString: "#fff")
        label.font = .weatherTempFont
        return label
    }()
    
    let iconImageView:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        //        iv.image = UIImage(named: "clear-day")
        return iv
    }()
    
    let tempIconView:UIView = {
        let view = UIView()
        return view
    }()
    
    let skyLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor(hexString: "#003264")
        label.font = .articleHeadlineFont
        return label
    }()
    
    let dividerLineView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#333")
        return view
    }()
    
    override func setupViews() {
        super.setupViews()
        
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [UIColor(hexString: "#003254")?.cgColor, UIColor(hexString: "#003254")?.cgColor, UIColor.white.cgColor]
        self.layer.insertSublayer(gradient, at: 0)
        
        addSubview(cityLabel)
        addSubview(tempIconView)
        addSubview(skyLabel)
        addSubview(dividerLineView)
        
        addConstraintsWithFormat(format: "H:|-12-[v0]-12-|", views: cityLabel)
        addConstraintsWithFormat(format: "H:|-12-[v0]-12-|", views: tempIconView)
        addConstraintsWithFormat(format: "H:|-12-[v0]-12-|", views: skyLabel)
        addConstraintsWithFormat(format: "H:|[v0]|", views: dividerLineView)
        
        addConstraintsWithFormat(format: "V:|-12-[v0]-4-[v1]-4-[v2]-12-[v3(0.5)]|", views: cityLabel, tempIconView, skyLabel, dividerLineView)
        
        tempIconView.addSubview(tempLabel)
        tempIconView.addSubview(iconImageView)
        
        addConstraintsWithFormat(format: "H:|-32-[v0]-4-[v1(100)]-32-|", views: tempLabel, iconImageView)
        addConstraintsWithFormat(format: "V:|[v0]", views: tempLabel)
        addConstraintsWithFormat(format: "V:|[v0(100)]", views: iconImageView)
    }
    
}
