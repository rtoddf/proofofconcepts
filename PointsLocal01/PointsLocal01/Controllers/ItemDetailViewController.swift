import UIKit

class ItemDetailViewController:UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var item:Item? {
        didSet {
            
        }
    }
    
    let headerCellId = "headerCellId"
    let textCellId = "textCellId"
    var cellHeight:CGFloat = 22.0

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView?.backgroundColor = .white
        collectionView?.alwaysBounceVertical = true
        
        collectionView?.register(ItemDetailHeaderCell.self, forCellWithReuseIdentifier: headerCellId)
        collectionView?.register(ItemDetailTextCell.self, forCellWithReuseIdentifier: textCellId)
        
        self.navigationController?.navigationBar.tintColor = .white
        
        // create the notification and add observer
        NotificationCenter.default.addObserver(self, selector: #selector(updateArticleHeight), name: NSNotification.Name(rawValue: "UpdateArticleHeight"), object: nil)
    }
    
    @objc func updateArticleHeight(notification: Notification) {
        guard let height = notification.object as? CGFloat else { return }
        cellHeight = height
        // redraw the collectionView using invalidateLayout
        collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: headerCellId, for: indexPath) as! ItemDetailHeaderCell
            cell.item = item
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: textCellId, for: indexPath) as! ItemDetailTextCell
        cell.item = item
        return cell
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 {
            return CGSize(width: view.frame.width, height: (9 / 16) * view.frame.width + 200)
        }
        
        return CGSize(width: view.frame.width, height: cellHeight)
    }
    
}
