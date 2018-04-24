import UIKit

class ChangeLocationTableViewController: UITableViewController {
    let getCurrentLocationCell = UITableViewCell()
    let settingsViewModel = SettingsViewModel(client: AzkarClient())

    let azkarLocationSettingsHeaderLabel = UILabel()
    let savedLocationsHeaderLabel = UILabel()
    let model = ChangeLocationViewModel()

    var indicator = UIActivityIndicatorView()

    let sectionsHeadersTitles = ["Azkar Location Settings", "Saved Locations"]
    let height: CGFloat = 50.0

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Change Location"
        model.delegate = self
        tableView.clipsToBounds = true
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
        azkarLocationSettingsHeaderLabel.textColor = .darkGray

        savedLocationsHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        savedLocationsHeaderLabel.text = sectionsHeadersTitles[1]
        savedLocationsHeaderLabel.textColor = .darkGray
    }

    private func configureIndicator() {
        indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        indicator.center = view.center
        view.addSubview(indicator)
    }

    private func configureDataCells() {
        getCurrentLocationCell.textLabel?.text = "Get Current Location (GPS)"
        getCurrentLocationCell.accessoryType = .disclosureIndicator
        getCurrentLocationCell.selectionStyle = .none

        tableView.tableFooterView = UIView()
    }

    // MARK: - Table view data source

    override func numberOfSections(in _: UITableView) -> Int {
        return sectionsHeadersTitles.count
    }

    override func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : model.favoritedLocations.count
    }

    override func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            return getCurrentLocationCell
        } else {
            let cell = UITableViewCell()
            cell.textLabel?.text = model.getLocationInfo(model.favoritedLocations[indexPath.row])
            if indexPath.row == 0 {
                cell.accessoryType = .checkmark
            }
            return cell
        }
    }

    override func tableView(_: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)

        if section == 0 {
            view.addSubview(azkarLocationSettingsHeaderLabel)
            NSLayoutConstraint.activate([
                azkarLocationSettingsHeaderLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15), azkarLocationSettingsHeaderLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 25),
            ])
        } else {
            view.addSubview(savedLocationsHeaderLabel)
            NSLayoutConstraint.activate([
                savedLocationsHeaderLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15), savedLocationsHeaderLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 25),
            ])
        }
        return view
    }

    override func tableView(_: UITableView, heightForHeaderInSection _: Int) -> CGFloat {
        return 50
    }

    // Marker: Table View Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            indicator.startAnimating()
            model.getCurrentLocation()
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            if let selectedCellText = tableView.cellForRow(at: indexPath)?.textLabel?.text {
                let location = model.getLocation(using: selectedCellText)
                model.addFavoritedLocation(location: location)
            }
            tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
    }
}

extension ChangeLocationTableViewController: ChangeLocationViewModelDelegate {
    func didRecieveLocation() {
        tableView.reloadData()
        indicator.stopAnimating()
        settingsViewModel.getAzkarTimes {
            self.settingsViewModel.restartAzkarNotifications()
        }
    }
}
