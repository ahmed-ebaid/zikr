//
//  AzkarViewController.swift
//  zikr
//
//  Created by Ahmed Ebaid on 4/8/18.
//  Copyright © 2018 Ahmed Ebaid. All rights reserved.
//

import UIKit

class AzkarViewController: UIViewController {
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var tableView: UITableView!
    
    var zikrView: ZikrQuranView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        configureTransparentNavigationBar()
    }
    
    private func configureTableView() {
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
    }
    private func configureTransparentNavigationBar() {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
    }
}

extension AzkarViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        zikrView = UINib(nibName: "ZikrQuranView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! ZikrQuranView
        zikrView.delegate = self
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        cell.contentView.addSubview(zikrView)
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        zikrView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            zikrView.topAnchor.constraint(equalTo: cell.contentView.topAnchor),
            zikrView.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor),
            zikrView.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor),
            zikrView.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor)
            ])
        return cell

    }
}

extension AzkarViewController : UITableViewDelegate {
    
}

extension AzkarViewController : ZikrQuranViewProtocol {    
    func azkarTableViewWillUpdateTable() {
        tableView.beginUpdates()
        tableView.endUpdates()
    }
}
