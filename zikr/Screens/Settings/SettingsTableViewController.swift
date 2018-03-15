import UIKit

class SettingsTableViewController: UITableViewController {
    let changeLocationCell = UITableViewCell()
    let calculationMethodCell = UITableViewCell()

    let changeLocationHeaderLabel = UILabel()
    let calculationMethodHeaderLabel = UILabel()

    let sectionsHeadersTitles = ["Azkar Settings", "Location Settings"]
    let height : CGFloat = 50.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "إعدادات"
        configureHeaderCells()
        configureDataCells()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    private func configureHeaderCells() {
        calculationMethodHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        calculationMethodHeaderLabel.text = sectionsHeadersTitles[0]
        calculationMethodHeaderLabel.textColor = UIColor.white
        
        changeLocationHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        changeLocationHeaderLabel.text = sectionsHeadersTitles[1]
        changeLocationHeaderLabel.textColor = UIColor.white
    }
    
    private func configureDataCells() {
        calculationMethodCell.textLabel?.text = "Calculation Method"
        calculationMethodCell.accessoryType = .disclosureIndicator
        calculationMethodCell.selectionStyle = .none
        
        changeLocationCell.textLabel?.text = "Change Location"
        changeLocationCell.accessoryType = .disclosureIndicator
        changeLocationCell.selectionStyle = .none
        
        tableView.tableFooterView = UIView()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionsHeadersTitles.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        default:
            fatalError("Unkown number of sections")
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                return calculationMethodCell
            default:
                fatalError("Unknown Cell")
            }
        case 1:
            return changeLocationCell
        default:
            fatalError("Unknown Cell")
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: height))
        view.backgroundColor = UIColor.lightGray
        
        switch section {
        case 0:
            view.addSubview(calculationMethodHeaderLabel)
            NSLayoutConstraint.activate([calculationMethodHeaderLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10), calculationMethodHeaderLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 15), calculationMethodHeaderLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15)])
        case 1:
            view.addSubview(changeLocationHeaderLabel)
            NSLayoutConstraint.activate([changeLocationHeaderLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10), changeLocationHeaderLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 15), changeLocationHeaderLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15)])
        default:
            fatalError("no section available")
        }
        return view
    }
    
    //Marker: Table View Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            let viewController = CalculationMethodTableViewController()
            self.navigationController?.pushViewController(viewController, animated: true)
        case 1:
            let viewController = ChangeLocationTableViewController()
            self.navigationController?.pushViewController(viewController, animated: true)
        default:
            fatalError("no section available")

        }
    }
}

