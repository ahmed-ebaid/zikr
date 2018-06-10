import UIKit

class CalculationMethodTableViewController: UITableViewController {
    let model = CalculationMethodViewModel()
    let settingsViewModel = SettingsViewModel(client: AzkarClient())
    var calculationMethod = 0
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        title = "Calculation Method"
        calculationMethod = model.calculationMethod
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if calculationMethod != model.calculationMethod {
            settingsViewModel.getAzkarTimes {
                self.settingsViewModel.restartAzkarNotifications()
            }
        }
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in _: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return model.calculationMethods.count
    }
    
    override func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "CALCULATION METHODS"
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "PLEASE REFER TO YOUR RELIGUOUS AUTORITY FOR THE COORECT CALCULATION METHOD TO USE"
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        model.setCalculationMethod(calculationMethod: model.calculationMethods[indexPath.row].0)
        tableView.reloadData()
    }
}

