import UIKit

class PointsLocalController:UICollectionViewController, UICollectionViewDelegateFlowLayout {
    let imageLargeCellId = "imageLargeCellId"
    let imageLeftCellId = "imageLeftCellId"
    let imageRightCellId = "imageRightCellId"
    let imageTopCellId = "imageTopCellId"
    var items:[Item]?
    var events:[Item]?
    
    var menu:[Menu]?
//    let menuLauncher = MenuLauncher()
    
    var categoryCellHeightDiff:CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = UIColor(hexString: "#ffffff")
        navigationItem.title = "Points Local"
        
        collectionView?.register(ArticleImageLargeCell.self, forCellWithReuseIdentifier: imageLargeCellId)
        collectionView?.register(ArticleImageLeftCell.self, forCellWithReuseIdentifier: imageLeftCellId)
        collectionView?.register(ArticleImageRightCell.self, forCellWithReuseIdentifier: imageRightCellId)
        collectionView?.register(ArticleImageTopCell.self, forCellWithReuseIdentifier: imageTopCellId)
        
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
        
        let feed = "\(feedBase)date_format=\(date_format)&time_format=\(time_format)&search=\(search)&tag=\(tag)&category=\(category)&latitude=\(latitude)&longitude=\(longitude)&radius=\(radius)&start=\(start)&end=\(end)&count=\(count)"
        let menuFeed = "http://rtodd.net/swift/data/menu-pointslocal.json"
        
//        Feed.downloadData(feedUrl: feed) { (items) in
//            self.items = items
//            self.collectionView?.reloadData()
//        }
        
        MenuItems.downloadData(feedUrl: menuFeed) {  menu in
            self.menu = menu
            guard let menuItems = self.menu else { return }
            self.menuLauncher.items = menuItems
            self.setupNavBarButtons()
            
            print("menu: \(menu)")
        }
        
        Events.downloadData(feedUrl: feed) { (items) in
            self.items = items
            self.collectionView?.reloadData()
        }

        collectionView?.dataSource = self
        collectionView?.delegate = self
    }
    
    func setupNavBarButtons() {
        // imaged for UIBarButtonItems must me at size
        let searchBarButtonItem = UIBarButtonItem(image: UIImage(named: "search")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleSearch))
        let menuButtonItem = UIBarButtonItem(image: UIImage(named: "bars")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(showMenu))
        navigationItem.leftBarButtonItems = [menuButtonItem]
        navigationItem.rightBarButtonItems = [searchBarButtonItem]
    }
    
    lazy var menuLauncher: MenuLauncher = {
        let launcher = MenuLauncher()
        launcher.pointsLocalController = self
        return launcher
    }()
    
    @objc func showMenu(){
        menuLauncher.showMenu()
        menuLauncher.pointsLocalController = self
    }
    
    func showController(item: Menu){
        guard let menuTitle = item.title else { return }
        
        var controllerToBePushed:Any
        let layout = UICollectionViewFlowLayout()

        if menuTitle == "Weather" {
            let weatherViewController = WeatherViewController(collectionViewLayout: layout)
            weatherViewController.menu = item
            navigationController?.pushViewController(weatherViewController, animated: true)
        } else {
//            let videoLauncher = VideoLauncher()
//            videoLauncher.showVideoPlayer()
            let whatToLoveViewController = WhatToLoveViewController(collectionViewLayout: layout)
            whatToLoveViewController.menu = item
            navigationController?.pushViewController(whatToLoveViewController, animated: true)
        }
    }
    
    @objc func handleSearch(){
        print("search")
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = items?.count else { return 0 }
        return count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item % 9 == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imageLargeCellId, for: indexPath) as! ArticleImageLargeCell
            cell.item = items?[indexPath.item]
            return cell
        }
        
        if indexPath.item % 9 == 1 || indexPath.item % 9 == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imageRightCellId, for: indexPath) as! ArticleImageRightCell
            cell.item = items?[indexPath.item]
            return cell
        }
        
        if indexPath.item % 9 == 3 || indexPath.item % 9 == 4 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imageLeftCellId, for: indexPath) as! ArticleImageLeftCell
            cell.item = items?[indexPath.item]
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imageTopCellId, for: indexPath) as! ArticleImageTopCell
        cell.item = items?[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.item % 9 == 0 {
            return CGSize(width: view.frame.width, height: 325 - categoryCellHeightDiff)
        }

        if indexPath.item % 9 == 1 || indexPath.item % 9 == 2 {
            return CGSize(width: view.frame.width, height: 120)
        }
        
        if indexPath.item % 9 == 3 || indexPath.item % 9 == 4 {
            return CGSize(width: view.frame.width, height: 120)
        }
        
        return CGSize(width: view.frame.width/2, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsetsMake(100, 0, 100, 0)
//    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = items?[indexPath.item] else { return }
        showArticleDetail(item: item)
    }
    
    func showArticleDetail(item: Item){
        let layout = UICollectionViewFlowLayout()
        let itemDetailViewController = ItemDetailViewController(collectionViewLayout: layout)
        itemDetailViewController.item = item
        navigationController?.pushViewController(itemDetailViewController, animated: true)
    }
}

