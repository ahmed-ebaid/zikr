import UIKit

private let reuseIdentifier = "Cell"

class AzkarCollectionViewController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        collectionView?.backgroundColor = .white
        let imageView = UIImageView(image: UIImage(named: "background.png"))
        imageView.frame = (collectionView?.frame)!
        collectionView?.backgroundView = imageView
        
        // Uncomment the following line to preserve selection between presentations

        
        
        // Register cell classes
        let nib = UINib(nibName: "CollectionViewCell", bundle: nil)
        collectionView?.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView?.contentInset = UIEdgeInsetsMake(100, 30, 100, 30)
        collectionView?.decelerationRate = UIScrollViewDecelerationRateFast
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateCellsLayout()
    }
    
    func updateCellsLayout()  {
        let centerX = (collectionView?.contentOffset.x)! + (collectionView?.frame.size.width)!/2
        for cell in (collectionView?.visibleCells)! {
            
            var offsetX = centerX - cell.center.x
            if offsetX < 0 {
                offsetX *= -1
            }
            cell.transform = CGAffineTransform.identity
            let offsetPercentage = offsetX / (view.bounds.width * 2.7)
            let scaleX = 1-offsetPercentage
            cell.transform = CGAffineTransform(scaleX: scaleX, y: scaleX)
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateCellsLayout()
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        let zikrView = Bundle.main.loadNibNamed("ZikrQuranView", owner: nil, options: nil)?.first as! ZikrQuranView
        zikrView.translatesAutoresizingMaskIntoConstraints = false
        
        cell.contentView.addSubview(zikrView)
        
        NSLayoutConstraint.activate([
            zikrView.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 0),
            zikrView.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor),
            zikrView.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor),
            zikrView.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor),
            ])
        
        return cell
    }
}

extension AzkarCollectionViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var cellSize: CGSize = collectionView.bounds.size
        
        cellSize.width -= collectionView.contentInset.left * 2
        cellSize.width -= collectionView.contentInset.right * 2
        cellSize.height = cellSize.height - collectionView.contentInset.top - collectionView.contentInset.bottom
        
        return cellSize
    }
}

extension AzkarCollectionViewController : ZikrQuranViewProtocol {
    func collectionViewUpdate() {
//        collectionView?.performBatchUpdates(nil, completion: nil)
    }
}

