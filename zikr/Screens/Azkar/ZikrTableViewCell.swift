//
//  ZikrTableViewCell.swift
//  zikr
//
//  Created by Ahmed Ebaid on 6/9/18.
//  Copyright © 2018 Ahmed Ebaid. All rights reserved.
//
import UIKit

protocol ZikrTableViewCellDelegate: class {
    func zikrTableViewCellPresentShareAvtivityController(cell: ZikrTableViewCell, text: [String])
    func zikrTableViewRedrawCell(cell: ZikrTableViewCell)
}

class ZikrTableViewCell: UITableViewCell {
    @IBOutlet var containerView: UIView!

    @IBOutlet var bismllahTitle: UILabel!
    @IBOutlet var zikr: UILabel!
    @IBOutlet var fadl: UILabel!
    @IBOutlet var numberOfTimes: UILabel!

    @IBOutlet weak var bismallahContainer: UIView!
    @IBOutlet weak var zikrContainer: UIView!
    @IBOutlet weak var fadlContainer: UIView!
    @IBOutlet weak var timesContainer: UIView!
    @IBOutlet var separatorView: UIView!

    weak var delegate: ZikrTableViewCellDelegate?

    func configureUI(zikrModel: ZikrModel) {
        bismllahTitle.text = zikrModel.title
        bismllahView(isHidden: zikrModel.title == "")

        zikr.text = zikrModel.zikr
        zikrView(isHidden: zikrModel.zikr == "")

        fadl.text = zikrModel.fadl
        fadlView(isHidden: zikrModel.fadl == "")

        numberOfTimes.text = zikrModel.numberOfTimes
        numberOfTimesView(isHidden: zikrModel.numberOfTimes == "")
    }

    private func bismllahView(isHidden: Bool) {
        bismallahContainer.isHidden = isHidden
    }

    private func zikrView(isHidden: Bool) {
        zikrContainer.isHidden = isHidden
    }

    private func fadlView(isHidden: Bool) {
        fadlContainer.isHidden = isHidden
    }

    private func numberOfTimesView(isHidden: Bool) {
        timesContainer.isHidden = isHidden
    }
}
