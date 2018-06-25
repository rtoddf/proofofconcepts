import UIKit

class ArticleImagesCell:BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    var articleDetailContoller:ArticleDetailController?
    
    @objc func animateView(sender: MyTapGesture){
        guard let imageView = sender.view else { return }
        guard let title = sender.title else { return }
        guard let caption = sender.caption else { return }
        guard let credit = sender.credit else { return }
        articleDetailContoller?.animate(image: imageView as! UIImageView, title: title, caption: caption, credit: credit)
    }
    
    let cellId = "cellId"

    var article:Article? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    let headerLabel:UILabel = {
        let label = UILabel()
        label.text = "Media"
        label.font = .extraLargeFont
        return label
    }()
    
    let collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        layout.scrollDirection = .horizontal
        return cv
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = article?.media?.count {
            return count
        }

        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! ImageCell

        if let image = article?.media![indexPath.item].path,
            let title = article?.media![indexPath.item].title,
            let caption = article?.media![indexPath.item].caption,
            let credit = article?.media![indexPath.item].credit {
            
            cell.articleImageView.loadImageUsingUrlString(imageUrl: image)
            let tappy = MyTapGesture(target: self, action: #selector(self.animateView))
            tappy.title = title
            tappy.caption = caption
            tappy.credit = credit
            
            cell.articleImageView.addGestureRecognizer(tappy)
        }
        
        return cell
    }
    
    class MyTapGesture: UITapGestureRecognizer {
        var title:String?
        var caption:String?
        var credit:String?
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = frame.width * 0.40
        let height = (9 / 16) * width
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    override func setupViews() {
        super.setupViews()

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: cellId)
        
        collectionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.animateView)))
        
        addSubview(headerLabel)
        addSubview(collectionView)

        addConstraintsWithFormat(format: "H:|-14-[v0]-14-|", views: headerLabel)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]-8-[v1]|", views: headerLabel, collectionView)
    }
}

class ImageCell:BaseCell {
    let articleImageView:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.backgroundColor = UIColor(hexString: "#333")
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    override func setupViews() {
        super.setupViews()
        addSubview(articleImageView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: articleImageView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: articleImageView)
    }
}
