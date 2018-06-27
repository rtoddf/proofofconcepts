import UIKit

class MainViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout  {
    let groupingCellId = "groupingCellId"
    var menu:[Menu]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = .white
        collectionView?.alwaysBounceVertical = true
        collectionView?.register(GroupingCell.self, forCellWithReuseIdentifier: groupingCellId)
        
        collectionView?.dataSource = self
        collectionView?.delegate = self
        
        let menuFeed = "http://rtodd.net/swift/data/menu.json"
        
        MenuItems.downloadData(feedUrl: menuFeed) { menu in
            self.menu = menu
            guard let menuItems = self.menu else { return }
            self.menuLauncher.items = menuItems
            self.setupNavBarButtons()
        }
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
        launcher.mainController = self
        return launcher
    }()
    
    @objc func showMenu(){
        menuLauncher.showMenu()
        menuLauncher.mainController = self
    }
    
    func showController(item: Menu){
        guard let menuTitle = item.title else { return }

        let layout = UICollectionViewFlowLayout()
        
        if menuTitle == "Weather" {
            let weatherViewController = WeatherViewController(collectionViewLayout: layout)
            weatherViewController.menu = item
            navigationController?.pushViewController(weatherViewController, animated: true)
        } else if menuTitle == "Events" {
            let sectionEventsViewController = SectionEventsViewController(collectionViewLayout: layout)
            sectionEventsViewController.menu = item
            sectionEventsViewController.section = menuTitle
            navigationController?.pushViewController(sectionEventsViewController, animated: true)
        } else {
            let sectionArticleViewController = SectionArticleViewController(collectionViewLayout: layout)
            sectionArticleViewController.menu = item
            sectionArticleViewController.section = menuTitle
            navigationController?.pushViewController(sectionArticleViewController, animated: true)
        }
    }

    func showArticleDetail(article: Article) {
        let layout = UICollectionViewFlowLayout()
        let articleDetailController = ArticleDetailController(collectionViewLayout: layout)
        articleDetailController.article = article
        navigationController?.pushViewController(articleDetailController, animated: true)
    }
    
    func showEventDetail(event: Event) {
        print("showEventDetail in MainController: \(event.headline)")
    }
    
    @objc func handleSearch(){
        print("handle search")
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: groupingCellId, for: indexPath) as! GroupingCell
        cell.groupCellIndex = indexPath.item
        // set maincontroller here!!! - https://stackoverflow.com/questions/31956495/uicollectionview-within-a-uicollectionviewcell-swift
//        it's self, not MainViewController!!!!
        cell.mainController = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 345 + (4 * 120) + 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

}

