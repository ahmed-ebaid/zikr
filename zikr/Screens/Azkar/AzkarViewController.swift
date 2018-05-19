//
//  AzkarViewController.swift
//  zikr
//
//  Created by Ahmed Ebaid on 4/8/18.
//  Copyright © 2018 Ahmed Ebaid. All rights reserved.
//

import UIKit

class AzkarViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var pageSelector: UISegmentedControl!
    
    let viewModel = ZikrQuranViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }

    private func configureTableView() {
        let zikrCellNib = UINib(nibName: "ZikrTableViewCell", bundle: nil)
        tableView.register(zikrCellNib, forCellReuseIdentifier: "zikrCell")
    }
    
    @IBAction func pageSelectorTapped(_ sender: UISegmentedControl) {
        tableView.reloadData()
    }
}

extension AzkarViewController: UITableViewDataSource {
    func numberOfSections(in _: UITableView) -> Int {
        return 1
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return viewModel.morningZikrModels.count
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "zikrCell") as! ZikrTableViewCell
        cell.delegate = self
        
        let zikrModel = pageSelector.selectedSegmentIndex == 0 ? viewModel.morningZikrModels[indexPath.row] : viewModel.eveningZikrModels[indexPath.row]

        cell.configureUI(zikrModel: zikrModel)
        return cell
    }
}

extension AzkarViewController: ZikrTableViewCellDelegate {
    func zikrTableViewCellPresentShareAvtivityController(cell: ZikrTableViewCell, text: [String]) {
        let activityController = UIActivityViewController(activityItems: text, applicationActivities: nil)
        activityController.setValue("Zikr application would like to share the following content with you", forKey: "Subject")
        present(activityController, animated: true)
    }

    func zikrTableViewRedrawCell(cell: ZikrTableViewCell) {
//        tableView.beginUpdates()
//        if let indexPath = tableView.indexPath(for: cell) {
//            tableView.cellForRow(at: indexPath)
//        }
//        tableView.endUpdates()
    }
}
