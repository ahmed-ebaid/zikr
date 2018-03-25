//
//  DoaaTableViewController.swift
//  zikr
//
//  Created by Ahmed Ebaid on 3/21/18.
//  Copyright © 2018 Ahmed Ebaid. All rights reserved.
//

import UIKit

class DoaaTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        configureTableViewBackground()
    }
    
    private func configureTableViewBackground() {
        let imageView = UIImageView(image: UIImage(named: "background.jpg"))
        imageView.frame = tableView.frame
        tableView.backgroundView = imageView
    }
    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//    }
//
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 300.0
//    }

}
