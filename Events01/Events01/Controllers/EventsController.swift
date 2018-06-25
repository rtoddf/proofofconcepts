import UIKit

class EventsController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    let feedMusicSource = "reviews-music"
    let feedMoviesSource = "reviews-movies"
    let version = ""
    let menuFeed = "http://rtodd.net/swift/data/menu-music.json"
    
    let imageLargeCellId = "imageLargeCellId"
    let imageLeftCellId = "imageLeftCellId"
    let imageRightCellId = "imageRightCellId"
    let imageTopCellId = "imageTopCellId"

    var articlesMusic:[Article]?
    var articlesMovies:[Article]?
//    var logo:String?
    var menu:[Menu]?
    var largeStoryCellHeadlineHeight:CGFloat = 20.0
    var categoryCellHeightDiff:CGFloat = 0.0
    
//    let videoCell = VideoCell()
    
    @objc func back(sender: UIBarButtonItem) {
        // Perform your custom actions
        // ...
        // Go back to the previous ViewController
//        videoCell.player?.pause()
        _ = navigationController?.popViewController(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: self, action: #selector(back(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
        
        collectionView?.backgroundColor = UIColor(hexString: "#fff")
        collectionView?.register(ArticleImageLargeCell.self, forCellWithReuseIdentifier: imageLargeCellId)
        collectionView?.register(ArticleImageLeftCell.self, forCellWithReuseIdentifier: imageLeftCellId)
        collectionView?.register(ArticleImageRightCell.self, forCellWithReuseIdentifier: imageRightCellId)
        collectionView?.register(ArticleImageTopCell.self, forCellWithReuseIdentifier: imageTopCellId)
        
        collectionView?.alwaysBounceVertical = true
        
        let navigationItemImageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: view.frame.width, height: view.frame.height)))
        navigationItemImageView.contentMode = .scaleAspectFit
        navigationItem.titleView = navigationItemImageView
        
        MenuItems.downloadData(feedUrl: menuFeed) { (menu, branding) in
            self.menu = menu
            guard let menuItems = self.menu else { return }
            self.menuLauncher.items = menuItems
            self.setupNavBarButtons()
            
            guard let logo = branding.logo else { return }
            navigationItemImageView.loadImageUsingUrlString(imageUrl: logo)
        }

        let feedMusic = "\(feedMusicSource)\(version)"
        Feed.downloadData(feedUrl: feedMusic) { articles in
            self.articlesMusic = articles
            self.collectionView?.reloadData()
        }
        
        let feedMovies = "\(feedMoviesSource)\(version)"
        Feed.downloadData(feedUrl: feedMovies) { articles in
            self.articlesMovies = articles
            self.collectionView?.reloadData()
        }

        collectionView?.dataSource = self
        collectionView?.delegate = self
        
        // notification for category label - LargeStoryCell
        notificationCenter.addObserver(self,
                                       selector: #selector(UpdateLargeStoryCellHeadlineHeight),
                                       name: .UpdateLargeStoryCellHeadlineHeight,
                                       object: nil)
        notificationCenter.addObserver(self,
                                       selector: #selector(updateCategoryCellHeight),
                                       name: .UpdateCategoryCellHeight,
                                       object: nil)

//        printFonts()
    }
    
    // notification selector for category label
    @objc func UpdateLargeStoryCellHeadlineHeight(notification: Notification) {
        guard let height = notification.object as? CGFloat else { return }
        largeStoryCellHeadlineHeight = height

        collectionView?.collectionViewLayout.invalidateLayout()
        collectionView?.layoutIfNeeded()
    }
    
    // notification selector for category label
    @objc func updateCategoryCellHeight(notification: Notification) {
        guard let height = notification.object as? CGFloat else { return }
        categoryCellHeightDiff = height
        
        collectionView?.collectionViewLayout.invalidateLayout()
        collectionView?.layoutIfNeeded()
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
        launcher.eventsController = self
        return launcher
    }()

    @objc func showMenu(){
        menuLauncher.showMenu()
        menuLauncher.eventsController = self
    }
    
    func showController(item: Menu){
        let layout = UICollectionViewFlowLayout()

        guard let menuTitle = item.title else { return }
        print("title: \(menuTitle)")
        
        if menuTitle == "Action & Adventure" {
            let actionAdventureViewController = ActionAdventureViewController(collectionViewLayout: layout)
            actionAdventureViewController.menu = item
            navigationController?.pushViewController(actionAdventureViewController, animated: true)
        } else if menuTitle == "Comedy" {
            let weatherViewController = WeatherViewController(collectionViewLayout: layout)
            weatherViewController.menu = item
            navigationController?.pushViewController(weatherViewController, animated: true)
        } else {
            let sectionViewController = SectionViewController(collectionViewLayout: layout)
            sectionViewController.menu = item
            navigationController?.pushViewController(sectionViewController, animated: true)
            //            let videoLauncher = VideoLauncher()
            //            videoLauncher.showVideoPlayer()
//            let whatToLoveViewController = WhatToLoveViewController(collectionViewLayout: layout)
//            whatToLoveViewController.menu = item
//            navigationController?.pushViewController(whatToLoveViewController, animated: true)
        }
    }

    @objc func handleSearch(){
       print("search")
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = articlesMusic?.count {
            return count
        }
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item % 7 == 0 {
//            print("articlesMusic: \(articlesMusic)")
//            print("articlesMovies: \(articlesMovies)")
            
            if let count = articlesMovies?.count {
                print("indexPath. count: \(count)")
            }
            
            print("indexPath.item: \(indexPath.item)")
            print("indexPath.row: \(indexPath.makeIterator())")
            print("indexPath.section: \(indexPath.section)")
            print("indexPath.item % 1: \(indexPath.item % 1)")
            
            var whichOne:Int = 0
            
            if indexPath.item >= 7 {
                whichOne = 1
            }
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imageLargeCellId, for: indexPath) as! ArticleImageLargeCell
            cell.article = articlesMovies?[whichOne]
            return cell
        }
        
        if indexPath.item % 7 == 1 || indexPath.item % 7 == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imageLeftCellId, for: indexPath) as! ArticleImageLeftCell
            cell.article = articlesMusic?[indexPath.item]
            return cell
        }
        
        if indexPath.item % 7 == 3 || indexPath.item % 7 == 4 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imageRightCellId, for: indexPath) as! ArticleImageRightCell
            cell.article = articlesMusic?[indexPath.item]
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imageTopCellId, for: indexPath) as! ArticleImageTopCell
        cell.article = articlesMusic?[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item % 7 == 0 {
            return CGSize(width: view.frame.width, height: 345 - categoryCellHeightDiff)
        }

        if indexPath.item % 7 == 1 || indexPath.item % 7 == 2 {
            return CGSize(width: view.frame.width, height: 120)
        }
        
        if indexPath.item % 7 == 3 || indexPath.item % 7 == 4 {
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
    //        return UIEdgeInsetsMake(0, 0, 0, 0)
    //    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let article = articlesMusic?[indexPath.item] else { return }
        showArticleDetail(article: article)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    func showArticleDetail(article: Article){
        let layout = UICollectionViewFlowLayout()
        let articleDetailViewController = ArticleDetailController(collectionViewLayout: layout)
        articleDetailViewController.article = article
        navigationController?.pushViewController(articleDetailViewController, animated: true)
    }
}
