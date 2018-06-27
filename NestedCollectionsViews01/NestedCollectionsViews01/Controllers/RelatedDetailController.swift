import UIKit

class RelatedDetailController:UICollectionViewController, UICollectionViewDelegateFlowLayout {
    let cellId = "cellId"
    let cellTextId = "cellTextid"
    let cellImagesId = "cellImagesId"
    //    let cellMapId = "cellMapId"
    let cellRelatedId = "cellRelatedId"
    
    // set a default var for headlineLabelHeight and detailTextCellHeight
    var headlineLabelHeight:CGFloat = 0.0
    var imageCaptionLabelHeight:CGFloat = 0.0
    var detailTextCellHeight:CGFloat = 22.0
    
    var relatedArticle:Article?
    var feed:String?
    
    var article:Item? {
        didSet {
            guard let guid = article?.guid else { return }
            self.feed = guid
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = UIColor(hexString: "#fff")
        
        guard let feed = feed else { return }
        Feed.downloadData(feedUrl: feed) { articles in
//            print("article: \(articles[0])")
            self.relatedArticle = articles[0]
        }
        
        collectionView?.backgroundColor = UIColor(hexString: "#fff")
        collectionView?.alwaysBounceVertical = true
        collectionView?.register(ArticleDetailCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(ArticleDetailTextCell.self, forCellWithReuseIdentifier: cellTextId)
        collectionView?.register(ArticleImagesCell.self, forCellWithReuseIdentifier: cellImagesId)
        //        collectionView?.register(ArticleDetailMapCell.self, forCellWithReuseIdentifier: cellMapId)
        collectionView?.register(ArticleRelatedCell.self, forCellWithReuseIdentifier: cellRelatedId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ArticleDetailCell
        print("relatedArticle: \(self.relatedArticle)")
        cell.article = self.relatedArticle
            return cell
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // lead image, headline, pubdate, and creator
//        if indexPath.item == 0 {
            // we dynamically size the cell based on the image, returned captionheight, returned headlinelabelheight + spacing in between all items
            return CGSize(width: view.frame.width, height: ((9 / 16) * view.frame.width) + 20)
//        }

    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView?.collectionViewLayout.invalidateLayout()
    }
}








