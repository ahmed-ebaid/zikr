
import UIKit

protocol ZikrQuranViewProtocol : class {
    func azkarTableViewWillUpdateTable()
}


class ZikrQuranView: UIView {
    weak var delegate: ZikrQuranViewProtocol?

    @IBOutlet weak var stackViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentViewGesture: UITapGestureRecognizer!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var fadlLabel: UILabel!
    @IBOutlet weak var numberOfTimesLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    private func configureUI() {
        stackViewHeightConstraint.constant = 0
    }
    
    @IBAction func contentViewGestureAction(_ sender: UITapGestureRecognizer) {
        UIView.animate(withDuration: 1.0) {
            self.stackViewHeightConstraint.constant =
            self.stackViewHeightConstraint.constant == 0 ? 100 : 0
            self.delegate?.azkarTableViewWillUpdateTable()
        }
    }
    
}