import UIKit

class CalculationMethodTableViewController: UITableViewController {
    let model = CalculationMethodViewModel()
    let settingsViewModel = SettingsViewModel(client: AzkarClient())

    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Calculation Method"
        tableView.clipsToBounds = true
        tableView.contentInset.bottom = 52
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
  
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.calculationMethods.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        cell.accessoryType = .none
        let indexOfSelectedCell = UserDefaults.standard.integer(forKey: "CalculationMethod")
        if model.calculationMethods[indexPath.row].1 == indexOfSelectedCell {
            cell.accessoryType = .checkmark
        }
        cell.textLabel?.text = model.calculationMethods[indexPath.row].0
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "PLEASE REFER TO YOUR RELIGUOUS AUTORITY FOR THE COORECT CALCULATION METHOD TO USE"
        label.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        label.numberOfLines = 0

        footerView.addSubview(label)
        
        NSLayoutConstraint.activate([label.leadingAnchor.constraint(equalTo: footerView.leadingAnchor, constant: 17), label.topAnchor.constraint(equalTo: footerView.topAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: footerView.trailingAnchor, constant: 10)])
        
        return footerView
    }
    
    //MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        model.setDefaultCalculationMethod(calculationMethod: model.calculationMethods[indexPath.row].0)
        settingsViewModel.getAzkarTimes {
            self.settingsViewModel.restartAzkarNotifications()
        }
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
}
