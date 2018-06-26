import UIKit

class ArticleRelatedCell:BaseCell, UITableViewDataSource, UITableViewDelegate {
    var articleDetailController: ArticleDetailController?
    let storyCellId = "storyCellId"
    
    var article:Article? {
        didSet {
            let count = article?.relatedContent?.items?.count
            guard let title = article?.relatedContent?.title else { return }
            
            headerLabel.text = title
            
            if count == nil {
                headerLabel.isHidden = true
                tableView.isHidden = true
            }
        }
    }
    
    let headerLabel:UILabel = {
        let label = UILabel()
        label.text = "Related Content"
        label.font = .extraLargeFont
        return label
    }()
    
    let tableView:UITableView = {
        let tv = UITableView()
        return tv
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = article?.relatedContent?.items?.count else { return 0 }
        
        if count == 0 {
            print("empty")
        }
        
        if count <= 4 {
            return count
        }
        
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: storyCellId, for: indexPath) as! RelatedTableCell
        
        if let relatedContent = article?.relatedContent?.items {
            cell.item = relatedContent[indexPath.item]
        }
        
        cell.articleDetailController = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let relatedContent = article?.relatedContent?.items else { return }
        print("click: \(relatedContent[indexPath.item]))")
        self.articleDetailController?.showArticleDetail()
        
//        let layout = UICollectionViewFlowLayout()
//        let articleDetailController = ArticleDetailController(collectionViewLayout: layout)
//        navigationController?.pushViewController(articleDetailController, animated: true)
    }
    
    override func setupViews() {
        addSubview(headerLabel)
        addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RelatedTableCell.self, forCellReuseIdentifier: storyCellId)
        
        addConstraintsWithFormat(format: "H:|-14-[v0]-14-|", views: headerLabel)
        addConstraintsWithFormat(format: "H:|[v0]|", views: tableView)
        addConstraintsWithFormat(format: "V:|[v0]-8-[v1(480)]", views: headerLabel, tableView)
    }
}

class RelatedTableCell:UITableViewCell {
    var articleDetailController: ArticleDetailController?
    
    var item:Item? {
        didSet {
            guard let headline = item?.headline else { return }
            guard let summary = item?.summary else { return }
            guard let image = item?.leadMedia?.path else { return }
            
            headlineLabel.text = headline
            summaryLabel.text = summary
            articleImageView.loadImageUsingUrlString(imageUrl: image)
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var headlineLabel:UILabel = {
        let label = UILabel()
        label.font = .titleFont
        label.numberOfLines = 2
        return label
    }()
    
    var summaryLabel:UILabel = {
        let label = UILabel()
        label.font = .labelFont
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let articleImageView:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = UIColor(hexString: "#333")
        return iv
    }()
    
    func setupViews(){
        addSubview(headlineLabel)
        addSubview(summaryLabel)
        addSubview(articleImageView)
        
        addConstraintsWithFormat(format: "H:|-14-[v0]-14-[v1(72)]-14-|", views: headlineLabel, articleImageView)
        addConstraintsWithFormat(format: "V:|-8-[v0]", views: headlineLabel)
        addConstraintsWithFormat(format: "V:|-8-[v0(72)]-8-|", views: articleImageView)
        
        addConstraint(NSLayoutConstraint(item: summaryLabel,  attribute: .left, relatedBy: .equal, toItem: headlineLabel, attribute: .left, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: summaryLabel,  attribute: .top, relatedBy: .equal, toItem: headlineLabel, attribute: .bottom, multiplier: 1, constant: 4))
        addConstraint(NSLayoutConstraint(item: summaryLabel,  attribute: .trailing, relatedBy: .equal, toItem: articleImageView, attribute: .leading, multiplier: 1, constant: -14))
    }
}
