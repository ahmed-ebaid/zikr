import UIKit

class SettingsTableViewController: UITableViewController {
    let changeLocationCell = UITableViewCell()
    let timeZoneCell = UITableViewCell()
    let azkarNotificationsCell = UITableViewCell()
    
    let locationSettingsLabel = UILabel()
    let azkarSettingsLabel = UILabel()
    let notificationSwitch = UISwitch()
    
    var model = AzkarNotificationsModel()
    
    let sectionsHeadersTitles = ["Location Settings", "Azkar Settings"]
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
        locationSettingsLabel.translatesAutoresizingMaskIntoConstraints = false
        locationSettingsLabel.text = sectionsHeadersTitles[0]
        locationSettingsLabel.textColor = UIColor.white
        
        azkarSettingsLabel.translatesAutoresizingMaskIntoConstraints = false
        azkarSettingsLabel.text = sectionsHeadersTitles[1]
        azkarSettingsLabel.textColor = UIColor.white
    }
    private func configureDataCells() {
        changeLocationCell.textLabel?.text = "Change Location"
        changeLocationCell.accessoryType = .disclosureIndicator
        changeLocationCell.selectionStyle = .none
        
        timeZoneCell.textLabel?.text = "Timezone Info"
        timeZoneCell.accessoryType = .disclosureIndicator
        timeZoneCell.selectionStyle = .none
        
        
        azkarNotificationsCell.selectionStyle = .none
        azkarNotificationsCell.textLabel?.text = "Azkar Notifications"
        
        notificationSwitch.setOn(true, animated: true)
        notificationSwitch.addTarget(self, action: #selector(notificationSwitchChanged), for: .valueChanged)
        azkarNotificationsCell.accessoryView = notificationSwitch
        
        tableView.tableFooterView = UIView()
    }
    
    @objc func notificationSwitchChanged() {
        model.toggleNotifications(with: notificationSwitch.isOn)
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionsHeadersTitles.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
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
                return changeLocationCell
            case 1:
                return timeZoneCell
            default:
                fatalError("Unknown Cell")
            }
        case 1:
            return azkarNotificationsCell
        default:
            fatalError("Unknown Cell")
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: height))
        view.backgroundColor = UIColor.lightGray
        
        switch section {
        case 0:
            view.addSubview(locationSettingsLabel)
            NSLayoutConstraint.activate([locationSettingsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10), locationSettingsLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 15), locationSettingsLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15)])
        case 1:
            view.addSubview(azkarSettingsLabel)
            NSLayoutConstraint.activate([azkarSettingsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10), azkarSettingsLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 15), azkarSettingsLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15)])
        default:
            fatalError("no section available")
        }
        return view
    }
}

