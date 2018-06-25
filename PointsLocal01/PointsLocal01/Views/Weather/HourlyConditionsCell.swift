import UIKit

class HourlyConditionsCell:BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    var hourlyConditions:[Hour]?
    let hourCellId = "hourCellId"
    
    let collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        layout.scrollDirection = .horizontal
        return cv
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = hourlyConditions?.count {
            return count
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hourCellId", for: indexPath) as! HourCell

        if let tempF = hourlyConditions?[indexPath.item].tempF,
            let precipChance = hourlyConditions?[indexPath.item].precipChance,
            let dateLocal = hourlyConditions?[indexPath.item].validDateLocal {

            cell.dateLabel.text = dateLocal.toDateString(inputDateFormat: "MM/dd/yyyy h:mm:ss a", ouputDateFormat: "h a").lowercased()
            cell.tempLabel.text = String(tempF)
            cell.precipChanceLabel.text = "Rain: " + String(precipChance) + "%"
        }

        if let count = hourlyConditions?.count {
            if indexPath.item == count - 1 {
                cell.dividerLineView.backgroundColor = .clear
            }
        }

        if indexPath.item % 2 == 1 {
            cell.backgroundColor = UIColor(hexString: "#dfdfdf")
        }
        
        //        cell.layer.borderWidth = 1.0
        //        cell.layer.borderColor = UIColor(hexString: "#333")?.cgColor
        
        return cell
    }
    
    let topDividerLineView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#333")
        return view
    }()
    
    let bottomDividerLineView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#333")
        return view
    }()
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = frame.width * 0.22
        let height = width
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    let headerLabel:UILabel = {
        let label = UILabel()
        label.text = "Hourly Weather"
        label.font = .extraLargeFont
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(HourCell.self, forCellWithReuseIdentifier: hourCellId)
        
        let weatherFeed = "http://weather.cmgdigital.com/USOH0245/"
        Weather.downloadHourlyWeather(feedUrl: weatherFeed) { hourlyConditions in
            self.hourlyConditions = hourlyConditions
            self.collectionView.reloadData()
        }
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        
        addSubview(headerLabel)
        addSubview(topDividerLineView)
        addSubview(collectionView)
        addSubview(bottomDividerLineView)
        
        addConstraintsWithFormat(format: "H:|-8-[v0]-8-|", views: headerLabel)
        addConstraintsWithFormat(format: "H:|[v0]|", views: topDividerLineView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: bottomDividerLineView)
        addConstraintsWithFormat(format: "V:|[v3]-4-[v0(0.5)][v1][v2(0.5)]|", views: topDividerLineView, collectionView, bottomDividerLineView, headerLabel)
    }
    
}

class HourCell:BaseCell {
    let dataView:UIView = {
        let view = UIView()
        return view
    }()
    
    var dateLabel:UILabel = {
        let label = UILabel()
        label.font = .weatherDailyDateFont
        label.textAlignment = .center
        return label
    }()
    
    let tempLabel:UILabel = {
        let label = UILabel()
        label.font = .weatherHourlyTempFont
        label.textAlignment = .center
        return label
    }()
    
    let precipChanceLabel:UILabel = {
        let label = UILabel()
        label.font = .weatherDailyDateFont
        label.textAlignment = .center
        return label
    }()
    
    let dividerLineView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#333")
        return view
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(dataView)
        addSubview(dividerLineView)

        dataView.addSubview(dateLabel)
        dataView.addSubview(tempLabel)
        dataView.addSubview(precipChanceLabel)

        addConstraintsWithFormat(format: "H:|[v0][v1(0.5)]|", views: dataView, dividerLineView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: dataView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: dividerLineView)

        addConstraintsWithFormat(format: "H:|[v0]|", views: dateLabel)
        addConstraintsWithFormat(format: "H:|[v0]|", views: tempLabel)
        addConstraintsWithFormat(format: "H:|[v0]|", views: precipChanceLabel)
        addConstraintsWithFormat(format: "V:|-8-[v0]-4-[v1]-4-[v2]", views: dateLabel, tempLabel, precipChanceLabel)
    }
}
