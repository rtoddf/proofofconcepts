import UIKit

class WeatherViewController:UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var city:City?
    var currentConditions:CurrentConditions?
    let currentConditionsCellId = "currentConditionsCellId"
    let dailyConditionsCellId = "dailyConditionsCellId"
    let hourlyConditionsCellId = "hourlyConditionsCellId"
    
    var menu:Menu? {
        didSet {
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = menu?.title
        navigationController?.navigationBar.tintColor = .white
        collectionView?.backgroundColor = .white
        collectionView?.alwaysBounceVertical = true
        self.navigationController?.navigationBar.tintColor = .white
        
        collectionView?.register(CurrentConditionsCell.self, forCellWithReuseIdentifier: currentConditionsCellId)
        collectionView?.register(DailyConditionsCell.self, forCellWithReuseIdentifier: dailyConditionsCellId)
        collectionView?.register(HourlyConditionsCell.self, forCellWithReuseIdentifier: hourlyConditionsCellId)
        
        let weatherFeed = "http://weather.cmgdigital.com/USOH0245/"
        Weather.downloadData(feedUrl: weatherFeed) { (city, currentConditions) in
            self.city = city
            self.currentConditions = currentConditions
            self.collectionView?.reloadData()
        }
        
        collectionView?.dataSource = self
        collectionView?.delegate = self
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: dailyConditionsCellId, for: indexPath) as! DailyConditionsCell
            return cell
        }

        if indexPath.item == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: hourlyConditionsCellId, for: indexPath) as! HourlyConditionsCell
            return cell
        }

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: currentConditionsCellId, for: indexPath) as! CurrentConditionsCell
        cell.city = city
        cell.currentConditions = currentConditions
        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 1 {
            let height = view.frame.width * 0.22
            return CGSize(width: view.frame.width, height: height + 26)
        }
        
        if indexPath.item == 2 {
            let height = 9 * 85
            return CGSize(width: view.frame.width, height: CGFloat(height + 26))
        }
        
        return CGSize(width: view.frame.width, height: 220)
    }
    
}
