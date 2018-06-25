// https://www.youtube.com/watch?v=2kwCfFG5fDA - youtube video

import UIKit

class MenuItem:NSObject {
    let name: String
    let imageName:String
    
    init(name:String, imageName:String){
        self.name = name
        self.imageName = imageName
    }
}

class MenuLauncher:NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    let blackView = UIView()
    var mainController: MainViewController?
    
    var items:[Menu]? {
        didSet {
            guard let allItems = items else { return }
            
            for menuItem in allItems {
                guard let title = menuItem.title else { return }
                menuItems.append(MenuItem(name: title, imageName: title))
            }
        }
    }
    
    let collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
    
    let cellId = "cellId"
    var cellHeight:CGFloat = 50
    
    var menuItems:[MenuItem] = {
        return[]
    }()
    
    func showMenu(){
        // show menu
        guard let window = UIApplication.shared.keyWindow else { return }
        blackView.backgroundColor = UIColor(white: 0, alpha: 0.35)
        blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
        
        window.addSubview(blackView)
        window.addSubview(collectionView)
        
        let menuXPosition:CGFloat = (window.frame.width/2) * -1
        let menuYPosition:CGFloat = 20
        let menuWidth:CGFloat = window.frame.width * 0.40
        collectionView.frame = CGRect(x: menuXPosition, y: menuYPosition, width: menuWidth, height: window.frame.height)
        
        blackView.frame = window.frame
        blackView.alpha = 0
        
        UIView.animate(withDuration: 0.35, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 1
            self.collectionView.frame = CGRect(x: 0, y: 20, width: self.collectionView.frame.width, height: window.frame.height)
        }, completion: nil)
    }
    
    @objc func handleDismiss() {
        UIView.animate(withDuration: 0.35, animations: {
            self.blackView.alpha = 0
            guard let window = UIApplication.shared.keyWindow else { return }
            self.collectionView.frame = CGRect(x: (window.frame.width/2) * -1, y: 20, width: window.frame.width * 0.40, height: window.frame.height)
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? MenuItemCell
        
        let setting = menuItems[indexPath.item]
        cell?.setting = setting
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.35, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 0
            guard let window = UIApplication.shared.keyWindow else { return }
            self.collectionView.frame = CGRect(x: (window.frame.width/2) * -1, y: 20, width: window.frame.width * 0.40, height: window.frame.height)
        }) { (completed:Bool) in
            guard let item = self.items?[indexPath.item] else { return }
            self.mainController?.showController(item: item)
        }
    }
    //    https://www.youtube.com/watch?v=DYsfAD01fYk&index=9&list=PL0dzCUj1L5JGKdVUtA5xds1zcyzsz7HLj @ about 5:00 and stopped at 19:47
    
    override init() {
        super.init()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MenuItemCell.self, forCellWithReuseIdentifier: cellId)
        
        collectionView.backgroundColor = UIColor(hexString: "#000", alpha: 0.25)
    }
}
