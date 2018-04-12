
import UIKit

protocol ZikrQuranViewProtocol : class {
    func azkarTableViewWillUpdateTable()
}

class ZikrQuranView: UIView {
    weak var delegate: ZikrQuranViewProtocol?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var fadlLabel: UILabel!
    @IBOutlet weak var numberOfTimesLabel: UILabel!
    @IBOutlet weak var separator: UIView!
    
    @IBOutlet weak var stackViewHeightConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    private func configureUI() {
        stackViewHeightConstraint.constant = 0
    }
    
    @IBAction func ZikrGestureAction(_ sender: UITapGestureRecognizer) {
        self.stackViewHeightConstraint.constant = self.stackViewHeightConstraint.constant == 0 ? 30 : 0
        self.separator.alpha = self.separator.alpha == 0.0 ? 1 : 0
        self.delegate?.azkarTableViewWillUpdateTable()
        
        UIView.animate(withDuration: 0.3) {
            self.separator.alpha = self.separator.alpha == 0 ? 1 : 0
        }
        
    }
}
