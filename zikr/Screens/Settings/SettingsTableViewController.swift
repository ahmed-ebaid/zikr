import UIKit

class SettingsTableViewController: UITableViewController {
    let calculationMethodCell = UITableViewCell()
    let changeLocationCell = UITableViewCell()
    
    let calculationMethodHeaderLabel = UILabel()
    let changeLocationHeaderLabel = UILabel()
    
    let sectionsHeadersTitles = ["Azkar Settings", "Location Settings"]
    let height : CGFloat = 75.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "إعدادات"
        configureHeaderCells()
        configureDataCells()
        configureScrollView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    private func configureHeaderCells() {
        calculationMethodHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        calculationMethodHeaderLabel.text = sectionsHeadersTitles[0]
        calculationMethodHeaderLabel.textColor = .darkGray
        
        changeLocationHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        changeLocationHeaderLabel.text = sectionsHeadersTitles[1]
        changeLocationHeaderLabel.textColor = .darkGray
    }
    
    private func configureDataCells() {
        calculationMethodCell.textLabel?.text = "Calculation Method"
        calculationMethodCell.accessoryType = .disclosureIndicator
        calculationMethodCell.selectionStyle = .none
        
        changeLocationCell.textLabel?.text = "Change Location"
        changeLocationCell.accessoryType = .disclosureIndicator
        changeLocationCell.selectionStyle = .none
        
        tableView.tableFooterView = UIView() //hides empty cells
    }
    
    private func configureScrollView() {
        tableView.bounces = false
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionsHeadersTitles.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return indexPath.section == 0 ? calculationMethodCell : changeLocationCell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        if section == 0 {
            view.addSubview(calculationMethodHeaderLabel)
            NSLayoutConstraint.activate([
                calculationMethodHeaderLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15), calculationMethodHeaderLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 25)])
        } else {
            view.addSubview(changeLocationHeaderLabel)
            NSLayoutConstraint.activate([
                changeLocationHeaderLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),changeLocationHeaderLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 25)])
        }
        return view
    }
    
    //Marker: Table View Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let viewController = CalculationMethodTableViewController()
            self.navigationController?.pushViewController(viewController, animated: true)
        } else {
            let viewController = ChangeLocationTableViewController()
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}

