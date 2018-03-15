import UIKit

class ChangeLocationTableViewController: UITableViewController {
    let getCurrentLocationCell = UITableViewCell()
    
    let azkarLocationSettingsHeaderLabel = UILabel()
    let savedLocationsHeaderLabel = UILabel()
    let model = ChangeLocationViewModel()
    
    let sectionsHeadersTitles = ["Azkar Location Settings", "Saved Locations"]
    let height : CGFloat = 50.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Change Location"
        configureHeaderCells()
        configureDataCells()
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
        switch section {
        case 0:
            return 1
        case 1:
            return model.favoritedLocations?.count ?? 1
        default:
            fatalError("Unkown number of sections")
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            return getCurrentLocationCell
        case 1:
            let cell = UITableViewCell()
            cell.textLabel?.text = model.getLocationInfo(model.favoritedLocations?[indexPath.row])
            if model.favoritedLocations != nil {
                if indexPath.row == (model.favoritedLocations?.count)! - 1 {
                    cell.accessoryType = .checkmark
                }
            }
            return cell
        default:
            fatalError("Unknown Cell")
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: height))
        view.backgroundColor = UIColor.lightGray
        
        switch section {
        case 0:
            view.addSubview(azkarLocationSettingsHeaderLabel)
            NSLayoutConstraint.activate([azkarLocationSettingsHeaderLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10), azkarLocationSettingsHeaderLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 15), azkarLocationSettingsHeaderLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15)])
        case 1:
            view.addSubview(savedLocationsHeaderLabel)
            NSLayoutConstraint.activate([savedLocationsHeaderLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10), savedLocationsHeaderLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 15), savedLocationsHeaderLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15)])
        default:
            fatalError("no section available")
        }
        return view
    }
    
    //Marker: Table View Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            model.getCurrentLocation()
            print("Got current locatoin")
            tableView.reloadData()
    
        case 1:
            //TODO: Go to Location Screen
            print("Location")
        default:
            fatalError("no section available")
            
        }
    }
    
}
