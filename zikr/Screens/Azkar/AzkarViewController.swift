//
//  AzkarViewController.swift
//  zikr
//
//  Created by Ahmed Ebaid on 4/8/18.
//  Copyright © 2018 Ahmed Ebaid. All rights reserved.
//

import UIKit

class AzkarViewController: UIViewController {
    @IBOutlet var navigationBar: UINavigationBar!
    @IBOutlet var tableView: UITableView!

    let viewModel = ZikrQuranViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
        configureTransparentNavigationBar()
    }

    private func configureTableView() {
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        let zikrCellNib = UINib(nibName: "ZikrTableViewCell", bundle: nil)
        tableView.register(zikrCellNib, forCellReuseIdentifier: "zikrCell")
    }

    private func configureTransparentNavigationBar() {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
    }
}

extension AzkarViewController: UITableViewDataSource {
    func numberOfSections(in _: UITableView) -> Int {
        return 1
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return viewModel.zikrModels.count
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "zikrCell") as! ZikrTableViewCell
        cell.selectionStyle = .none
        let zikrModel = viewModel.zikrModels[indexPath.row]
        cell.configureUI(zikrModel: zikrModel)
        return cell
    }
}

extension AzkarViewController: UITableViewDelegate {
    
}

extension AzkarViewController: ZikrTableViewCellDelegate {
    func zikrTableViewCellPresentAvtivityController(with text: [String]) {
        let activityController = UIActivityViewController(activityItems: text, applicationActivities: nil)
        activityController.setValue("Zikr application would like to share the following content with you", forKey: "Subject")
        present(activityController, animated: true, completion: nil)
    }

    func ZikrTableViewCellUpdate() {
        tableView.beginUpdates()
        tableView.endUpdates()
    }
}
