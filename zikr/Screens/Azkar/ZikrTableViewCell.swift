import UIKit

protocol ZikrTableViewCellDelegate: class {
    func zikrTableViewCellPresentShareAvtivityController(cell: ZikrTableViewCell, text: [String])
    func zikrTableViewRedrawCell(cell: ZikrTableViewCell)
}

class ZikrTableViewCell: UITableViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var bismllahBottom: NSLayoutConstraint!
    @IBOutlet weak var bismllahTop: NSLayoutConstraint!
    @IBOutlet weak var zikrTop: NSLayoutConstraint!
    @IBOutlet weak var zikrBottom: NSLayoutConstraint!
    @IBOutlet weak var fadlTop: NSLayoutConstraint!
    @IBOutlet weak var fadlBottom: NSLayoutConstraint!
    @IBOutlet weak var numberOfTimesBottom: NSLayoutConstraint!
    @IBOutlet weak var numberOfTimesTop: NSLayoutConstraint!
    @IBOutlet weak var stackViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var bismllahTitle: UILabel!
    @IBOutlet weak var zikr: UILabel!
    @IBOutlet weak var fadl: UILabel!
    @IBOutlet weak var numberOfTimes: UILabel!
    
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    
    weak var delegate: ZikrTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tap.delegate = self
        stackViewHeight.constant = 0
        containerView.addGestureRecognizer(tap)
    }
    
    func configureUI(zikrModel: ZikrModel) {
        bismllahTitle.text = zikrModel.title
        bismllahView(hide: zikrModel.title == "")
       
        zikr.text = zikrModel.zikr
        zikrView(hide: zikrModel.zikr == "")
        
        fadl.text = zikrModel.fadl
        fadlView(hide: zikrModel.fadl == "")
        
        numberOfTimes.text = zikrModel.numberOfTimes
        numberOfTimesView(hide: zikrModel.numberOfTimes == "")
    }
    
    private func bismllahView(hide: Bool) {
        bismllahBottom.constant = hide ? 0 : 16
        bismllahTop.constant = hide ? 0 : 16
    }
    
    private func zikrView(hide: Bool) {
        zikrTop.constant = hide ? 0 : 16
        zikrBottom.constant = hide ? 0 : 16
    }
    
    private func fadlView(hide: Bool) {
        fadlTop.constant = hide ? 0 : 16
        fadlBottom.constant = hide ? 0 : 16
    }
    
    private func numberOfTimesView(hide: Bool) {
        numberOfTimesTop.constant = hide ? 0 : 16
        numberOfTimesBottom.constant = hide ? 0 : 16
    }

    @IBAction func share(_ sender: UIButton) {
        //TODO: delegate action in the controller
    }
    
    @IBAction func favorite(_ sender: UIButton) {
        //TODO: delegate action in the controller
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        UIView.animate(withDuration: 3.0) {
            self.separatorView.alpha = 0
            self.stackView.alpha = 0
       
            self.stackViewHeight.constant = self.stackViewHeight.constant == 0 ? 40 : 0
            self.delegate?.zikrTableViewRedrawCell(cell: self)
        
            self.separatorView.alpha = 1
            self.stackView.alpha = 1
        }
    }
}
