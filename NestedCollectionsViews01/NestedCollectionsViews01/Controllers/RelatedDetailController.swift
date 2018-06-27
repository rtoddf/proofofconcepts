import UIKit

class RelatedDetailController:UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var article:Item? {
        didSet {
            guard let guid = article?.guid else { return }
            
            Feed.downloadData(feedUrl: guid) { articles in
                print("articles: \(articles)")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
