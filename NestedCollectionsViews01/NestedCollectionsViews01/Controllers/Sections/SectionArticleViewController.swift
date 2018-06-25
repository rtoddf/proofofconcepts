import UIKit

class SectionArticleViewController:UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var section:String?
    var feed:String?
    
    let feedMusicSource = "reviews-music"
    let feedMoviesSource = "reviews-movies"
    let feedPlacesSource = "reviews-places"
    let version = ""
    let articleImageLargeCellId = "articleImageLargeCellId"
    
    var articles:[Article]?
    
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
        
        guard let section = section else { return }
        if section == "What to Know" {
            feed = "\(feedMoviesSource)\(version)"
        } else if section == "What to Do" {
            feed = "\(feedMusicSource)\(version)"
        } else {
            feed = "\(feedPlacesSource)\(version)"
        }
        
        guard let feed = feed else { return }
        Feed.downloadData(feedUrl: feed) { articles in
            self.articles = articles
            self.collectionView?.reloadData()
        }
        
        collectionView?.register(ArticleImageLargeCell.self, forCellWithReuseIdentifier: articleImageLargeCellId)
        collectionView?.dataSource = self
        collectionView?.delegate = self
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = articles?.count else { return 0 }
        return count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "articleImageLargeCellId", for: indexPath) as! ArticleImageLargeCell
        cell.article = articles?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 345)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = articles?[indexPath.item] else { return }
        showArticleDetail(item: item)
    }
    
    func showArticleDetail(item: Article){
        let layout = UICollectionViewFlowLayout()
        let articleDetailContoller = ArticleDetailController(collectionViewLayout: layout)
        articleDetailContoller.article = item
        navigationController?.pushViewController(articleDetailContoller, animated: true)
    }
}
