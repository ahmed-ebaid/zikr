//
//  ChangeLocationTableViewController.swift
//  zikr
//
//  Created by Ahmed Ebaid on 6/9/18.
//  Copyright © 2018 Ahmed Ebaid. All rights reserved.
//
import UIKit

class ChangeLocationTableViewController: UITableViewController {
    let getCurrentLocationCell = UITableViewCell()

    let viewModel: SettingsViewModel

    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "ChangeLocationTableViewController", bundle: nil)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let sectionsHeadersTitles = ["Azkar Location Settings", "Saved Locations"]

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Change Location"
        NotificationCenter.default.addObserver(self, selector: #selector(didChangeLocationNotification), name: Location.DidChangeLocationNotification, object: nil)
        configureDataCells()
    }

    private func configureDataCells() {
        getCurrentLocationCell.textLabel?.text = "Get Current Location (GPS)"
        getCurrentLocationCell.accessoryType = .disclosureIndicator
        getCurrentLocationCell.selectionStyle = .none
    }

    // MARK: - Table view data source

    override func numberOfSections(in _: UITableView) -> Int {
        return sectionsHeadersTitles.count
    }

    override func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : viewModel.location.favoritedLocations.count
    }

    override func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            return getCurrentLocationCell
        } else {
            let cell = UITableViewCell()
            cell.textLabel?.text = viewModel.location.getLocationInfo(viewModel.location.favoritedLocations[indexPath.row])
            if indexPath.row == 0 {
                cell.accessoryType = .checkmark
            }
            return cell
        }
    }

    // Marker: Table View Delegate Methods

    override func tableView(_: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionsHeadersTitles[section]
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            startActivtyIndicator()
            viewModel.location.getCurrentLocation()
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            if let selectedCellText = tableView.cellForRow(at: indexPath)?.textLabel?.text {
                let location = viewModel.location.getLocation(using: selectedCellText)
                viewModel.location.addFavoritedLocation(location: location)
            }
            tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
    }

    @objc private func didChangeLocationNotification() {
        tableView.reloadData()
        stopActivityIndicator()
        viewModel.getAzkarTimes {
            self.viewModel.refreshAzkarNotifications()
        }
    }
}
