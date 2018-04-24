//
//  ZikrTableViewCell.swift
//  zikr
//
//  Created by Ahmed Ebaid on 4/22/18.
//  Copyright © 2018 Ahmed Ebaid. All rights reserved.
//

import UIKit

protocol ZikrTableViewCellDelegate {
    func zikrTableViewCellPresentAvtivityController(with text: [String])
    func ZikrTableViewCellUpdate()
}

class ZikrTableViewCell: UITableViewCell {
    @IBOutlet weak var bismAllahView: UIView!
    @IBOutlet weak var zikrView: UIView!
    @IBOutlet weak var fadlView: UIView!
    @IBOutlet weak var timesView: UIView!
    @IBOutlet weak var actionsView: UIStackView!
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var zikr: UILabel!
    @IBOutlet weak var fadl: UILabel!
    @IBOutlet weak var numberOfTimes: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureUI(zikrModel: ZikrModel) {
        title.text = zikrModel.title
        zikr.text = zikrModel.zikr
        fadl.text = zikrModel.fadl
        numberOfTimes.text = zikrModel.numberOfTimes
    }


    @IBAction func share(_ sender: UIButton) {
        print("share")
    }
    
    @IBAction func favorite(_ sender: UIButton) {
    }
    
    
    
}
