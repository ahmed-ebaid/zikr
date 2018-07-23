//
//  CalculationMethodTableViewController.swift
//  zikr
//
//  Created by Ahmed Ebaid on 6/9/18.
//  Copyright © 2018 Ahmed Ebaid. All rights reserved.
//

import UIKit

class CalculationMethodTableViewController: UITableViewController {
    let viewModel: SettingsViewModel
    var calculationMethod = 0
    
    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "CalculationMethodTableViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        title = "Calculation Method"
        calculationMethod = viewModel.calculationMethod.calculationMethodIndex
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if calculationMethod != viewModel.calculationMethod.calculationMethodIndex {
            viewModel.getAzkarTimes {
                self.viewModel.refreshAzkarNotifications()
            }
        }
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in _: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return viewModel.calculationMethod.azkarCalculationMethods.count
    }
    
    override func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        cell.accessoryType = .none
        let indexOfSelectedCell = UserDefaults.standard.integer(forKey: "CalculationMethod")
        if viewModel.calculationMethod.azkarCalculationMethods[indexPath.row].1 == indexOfSelectedCell {
            cell.accessoryType = .checkmark
        }
        cell.textLabel?.text = viewModel.calculationMethod.azkarCalculationMethods[indexPath.row].0
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
        viewModel.calculationMethod.setCalculationMethod(calculationMethod: viewModel.calculationMethod.azkarCalculationMethods[indexPath.row].0)
        tableView.reloadData()
    }
}

