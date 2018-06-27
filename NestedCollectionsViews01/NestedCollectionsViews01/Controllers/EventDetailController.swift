import UIKit

class EventDetailController:UICollectionViewController, UICollectionViewDelegateFlowLayout {
    let cellId = "cellId"
    let cellTextId = "cellTextid"
    var cellHeight:CGFloat = 22.0

    var event:Event? {
        didSet {
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = UIColor(hexString: "#fff")
        self.navigationController?.navigationBar.tintColor = .white
        
        collectionView?.alwaysBounceVertical = true
        collectionView?.register(EventDetailCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(EventDetailTextCell.self, forCellWithReuseIdentifier: cellTextId)
        
        // create the notification and add observer
        NotificationCenter.default.addObserver(self, selector: #selector(updateEventTextHeight), name: NSNotification.Name(rawValue: "UpdateEventTextHeight"), object: nil)
    }
    
    @objc func updateEventTextHeight(notification: Notification) {
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! EventDetailCell
            cell.event = event
            return cell
        }
        
        // article text
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellTextId, for: indexPath) as! EventDetailTextCell
        cell.event = event
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 {
            return CGSize(width: view.frame.width, height: (9 / 16) * view.frame.width + 200)
        }

        return CGSize(width: view.frame.width, height: cellHeight)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView?.collectionViewLayout.invalidateLayout()
    }
}




