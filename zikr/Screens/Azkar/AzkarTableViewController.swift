import UIKit

class AzkarTableViewController: UITableViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 300
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let zikrView = UINib(nibName: "ZikrQuranView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! ZikrQuranView
        zikrView.delegate = self
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        cell.contentView.addSubview(zikrView)
        zikrView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            zikrView.topAnchor.constraint(equalTo: cell.contentView.topAnchor),
            zikrView.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor),
            zikrView.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor),
            zikrView.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor)
            ])

        return cell
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell = tableView.cellForRow(at: indexPath)
//        let view = cell?.contentView.subviews[0] as! ZikrQuranView
//        UIView.animate(withDuration: 1.0) {
//            view.stackViewHeightConstraint.constant =
//                view.stackViewHeightConstraint.constant == 0 ? 100 : 0
//            tableView.beginUpdates()
//            tableView.endUpdates()
//        }
//    }
}

extension AzkarTableViewController : ZikrQuranViewProtocol {
    func azkarTableViewWillUpdateTable() {
        tableView.beginUpdates()
        tableView.endUpdates()
    }
}
