//
//  SettingsTableViewController.swift
//  zikr
//
//  Created by Ahmed Ebaid on 6/9/18.
//  Copyright © 2018 Ahmed Ebaid. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    let calculationMethodCell = UITableViewCell()
    let changeLocationCell = UITableViewCell()
    var viewModel: SettingsViewModel
    
    let sectionsHeadersTitles = ["Azkar Settings", "Location Settings"]
    
    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "SettingsTableViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "إعدادات"
        configureDataCells()
    }
    
    private func configureDataCells() {
        calculationMethodCell.textLabel?.text = "Calculation Method"
        calculationMethodCell.accessoryType = .disclosureIndicator
        calculationMethodCell.selectionStyle = .none
        
        changeLocationCell.textLabel?.text = "Change Location"
        changeLocationCell.accessoryType = .disclosureIndicator
        changeLocationCell.selectionStyle = .none
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in _: UITableView) -> Int {
        return sectionsHeadersTitles.count
    }
    
    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return 1
    }
    
    override func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return indexPath.section == 0 ? calculationMethodCell : changeLocationCell
    }
    
    // Marker: Table View Delegate Methods
    override func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let viewController = CalculationMethodTableViewController(viewModel: viewModel)
            navigationController?.pushViewController(viewController, animated: true)
        } else {
            let viewController = ChangeLocationTableViewController(viewModel: viewModel)
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionsHeadersTitles[section]
    }
}

