import UIKit

class SectionEventsViewController:UICollectionViewController, UICollectionViewDelegateFlowLayout {
    let articleImageTopCellId = "articleImageTopCellId"
    var section:String?
    var feed:String?

    var events:[Event]?
    
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
        
        let feedBase = "https://dayton.pointslocal.com/api/v1/events?"
        let date_format = "F%20j,%20Y"
        let time_format = "g:i%20a"
        let search = "festival"
        let tag = ""
        let category = ""
        let latitude = "39.7794694"
        let longitude = "-84.2721968"
        let radius = "25"
        let start = "today"
        let end = "+30%20days"
        let count = "14"
        
        let feedEvents = "\(feedBase)date_format=\(date_format)&time_format=\(time_format)&search=\(search)&tag=\(tag)&category=\(category)&latitude=\(latitude)&longitude=\(longitude)&radius=\(radius)&start=\(start)&end=\(end)&count=\(count)"
        
        feed = "\(feedEvents)"
        
        guard let feed = feed else { return }
        Events.downloadData(feedUrl: feed) { (events) in
            self.events = events
            self.collectionView?.reloadData()
        }
        
        collectionView?.register(ArticleImageTopCell.self, forCellWithReuseIdentifier: articleImageTopCellId)
        collectionView?.dataSource = self
        collectionView?.delegate = self
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = events?.count else { return 0 }
        return count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "articleImageTopCellId", for: indexPath) as! ArticleImageTopCell
        cell.event = events?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       return CGSize(width: view.frame.width/2, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = events?[indexPath.item] else { return }
        showArticleDetail(item: item)
    }

    func showArticleDetail(item: Event){
        let layout = UICollectionViewFlowLayout()
        let eventDetailContoller = EventDetailController(collectionViewLayout: layout)
        eventDetailContoller.event = item
        navigationController?.pushViewController(eventDetailContoller, animated: true)
    }
}
