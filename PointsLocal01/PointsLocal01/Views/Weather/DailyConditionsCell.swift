import UIKit

class DailyConditionsCell:BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    var dailyConditions:[Day]?
    let dayCellId = "dayCellId"

    let collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
//        layout.scrollDirection = .horizontal
        return cv
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = dailyConditions?.count {
            return count
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dayCellId", for: indexPath) as! DayCell
        
        if let hiTempF = dailyConditions?[indexPath.item].hiTempF,
            let loTempF = dailyConditions?[indexPath.item].loTempF,
            let precipChance = dailyConditions?[indexPath.item].precipChance,
            let dateLocal = dailyConditions?[indexPath.item].validDateLocal {
            
            cell.dateLabel.text = dateLocal.toDateString(inputDateFormat: "MM/dd/yyyy h:mm:ss a", ouputDateFormat: "E, MMM dd")
            cell.tempLabel.text = String(loTempF) + " / " + String(hiTempF)
            cell.precipChanceLabel.text = "Rain: " + String(precipChance) + "%"
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
        return CGSize(width: frame.width, height: 75)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    let headerLabel:UILabel = {
        let label = UILabel()
        label.text = "Daily Weather"
        label.font = .extraLargeFont
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(DayCell.self, forCellWithReuseIdentifier: dayCellId)
        
        let weatherFeed = "http://weather.cmgdigital.com/USOH0245/"
        Weather.downloadDailyWeather(feedUrl: weatherFeed) { dailyConditions in
            self.dailyConditions = dailyConditions
            self.collectionView.reloadData()
        }
        
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

class DayCell:BaseCell {
    let dataView:UIView = {
        let view = UIView()
        
        return view
    }()
    
    var dateLabel:UILabel = {
        let label = UILabel()
        label.font = .weatherDailyDateFont
        return label
    }()
    
    let tempLabel:UILabel = {
        let label = UILabel()
        label.font = .weatherDailyTempFont
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
//        dataView.addSubview(precipChanceLabel)
        
        let quarterWidth = frame.width * 0.3
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: dataView)
        addConstraintsWithFormat(format: "V:|[v0][v1(0.75)]|", views: dataView, dividerLineView)

        addConstraintsWithFormat(format: "H:|-8-[v0(\(quarterWidth))]|", views: dateLabel)
        addConstraintsWithFormat(format: "H:|-8-[v0(\(quarterWidth))]|", views: tempLabel)
        addConstraintsWithFormat(format: "V:|-8-[v0]-4-[v1]", views: dateLabel, tempLabel)
        
//        addConstraintsWithFormat(format: "H:|[v0]|", views: precipChanceLabel)
//        addConstraintsWithFormat(format: "V:|-8-[v0]-4-[v1]-4-[v2]", views: dateLabel, tempLabel, precipChanceLabel)
    }
}








