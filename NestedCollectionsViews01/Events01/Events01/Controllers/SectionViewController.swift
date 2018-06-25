import UIKit

class SectionViewController:UICollectionViewController, UICollectionViewDelegateFlowLayout {
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
    }
    
}
