
import UIKit

protocol ZikrQuranViewDelegate: class {
    func zikrQuranViewWillUpdateTable()
    func zikrQuranViewPresentActivityController(with text: [String])
}

class ZikrQuranView: UIView {
    weak var delegate: ZikrQuranViewDelegate?
    let viewModel = ZikrQuranViewModel()

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var fadlLabel: UILabel!
    @IBOutlet var numberOfTimesLabel: UILabel!
    @IBOutlet var separator: UIView!

    @IBOutlet var stackViewHeightConstraint: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }

    func configure(with model: ZikrModel) {
        titleLabel.text = model.title
        descriptionLabel.text = model.zikr
        fadlLabel.text = model.fadl
        numberOfTimesLabel.text = model.numberOfTimes
    }

    private func configureUI() {
        stackViewHeightConstraint.constant = 0
    }

    @IBAction func zikrContainerTappedAction(_: UITapGestureRecognizer) {
        stackViewHeightConstraint.constant = stackViewHeightConstraint.constant == 0 ? 30 : 0
        separator.alpha = separator.alpha == 0.0 ? 1 : 0
        delegate?.zikrQuranViewWillUpdateTable()

        UIView.animate(withDuration: 0.3) {
            self.separator.alpha = self.separator.alpha == 0 ? 1 : 0
        }
    }

    @IBAction func shareButtonTapped(_: UIButton) {
    }

    @IBAction func favoriteButtonTapped(_: UIButton) {
    }
}
