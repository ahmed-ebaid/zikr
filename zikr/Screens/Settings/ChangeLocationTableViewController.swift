import UIKit

class ChangeLocationTableViewController: UITableViewController, ChangeLocationViewModelDelegate {
    let getCurrentLocationCell = UITableViewCell()
    
    let azkarLocationSettingsHeaderLabel = UILabel()
    let savedLocationsHeaderLabel = UILabel()
    let model = ChangeLocationViewModel()
    
    var indicator = UIActivityIndicatorView()
    
    let sectionsHeadersTitles = ["Azkar Location Settings", "Saved Locations"]
    let height : CGFloat = 50.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Change Location"
        model.delegate = self
        configureHeaderCells()
        configureDataCells()
        configureIndicator()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    private func configureHeaderCells() {
        azkarLocationSettingsHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        azkarLocationSettingsHeaderLabel.text = sectionsHeadersTitles[0]
        azkarLocationSettingsHeaderLabel.textColor = UIColor.white
        
        savedLocationsHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        savedLocationsHeaderLabel.text = sectionsHeadersTitles[1]
        savedLocationsHeaderLabel.textColor = UIColor.white
    }
    
    private func configureIndicator() {
        indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        indicator.center = self.view.center
        self.view.addSubview(indicator)
    }
    
    private func configureDataCells() {
        getCurrentLocationCell.textLabel?.text = "Get Current Location (GPS)"
        getCurrentLocationCell.accessoryType = .disclosureIndicator
        getCurrentLocationCell.selectionStyle = .none
        
        tableView.tableFooterView = UIView()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionsHeadersTitles.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : model.favoritedLocations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            return getCurrentLocationCell
        } else {
            let cell = UITableViewCell()
            cell.textLabel?.text = model.getLocationInfo(model.favoritedLocations[indexPath.row])
            if indexPath.row == (model.favoritedLocations.count) - 1 {
                cell.accessoryType = .checkmark
            }
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.7)
        
        if section == 0 {
            view.addSubview(azkarLocationSettingsHeaderLabel)
            NSLayoutConstraint.activate([azkarLocationSettingsHeaderLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10), azkarLocationSettingsHeaderLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 15), azkarLocationSettingsHeaderLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15)])
        } else {
            view.addSubview(savedLocationsHeaderLabel)
            NSLayoutConstraint.activate([savedLocationsHeaderLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10), savedLocationsHeaderLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 15), savedLocationsHeaderLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15)])
        }
        return view
    }
    
    //Marker: Table View Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            indicator.startAnimating()
            model.getCurrentLocation()
        }
    }
    
    //Mark ChangeLocationViewModelDelegate delegate method
    func didRecieveLocation() {
        tableView.reloadData()
        indicator.stopAnimating()
    }
}
