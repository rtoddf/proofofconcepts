import UIKit

class WeatherViewController:UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var city:City?
    var dailyConditions:[Day]?
    var currentConditions:CurrentConditions?
    let currentConditionsCellId = "currentConditionsCellId"
    
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
        
        let weatherFeed = "http://weather.cmgdigital.com/30152/"
        Weather.downloadData(feedUrl: weatherFeed) { (city, currentConditions, dailyConditions) in
            self.city = city
            self.currentConditions = currentConditions
            //            self.dailyConditions = dailyConditions
            self.collectionView?.reloadData()
        }
        
        collectionView?.dataSource = self
        collectionView?.delegate = self
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //        if indexPath.item == 0 {
        //            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: headerCellId, for: indexPath) as! ItemDetailHeaderCell
        //            cell.item = item
        //            return cell
        //        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: currentConditionsCellId, for: indexPath) as! CurrentConditionsCell
        cell.city = city
        cell.currentConditions = currentConditions
        //        cell.city = city
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //        if indexPath.item == 0 {
        //            return CGSize(width: view.frame.width, height: (9 / 16) * view.frame.width + 200)
        //        }
        
        return CGSize(width: view.frame.width, height: 220)
    }
    
}
