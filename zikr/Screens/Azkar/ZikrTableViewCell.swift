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
    @IBOutlet var bismllahBottom: NSLayoutConstraint!
    @IBOutlet var bismllahTop: NSLayoutConstraint!
    @IBOutlet var zikrTop: NSLayoutConstraint!
    @IBOutlet var zikrBottom: NSLayoutConstraint!
    @IBOutlet var fadlTop: NSLayoutConstraint!
    @IBOutlet var fadlBottom: NSLayoutConstraint!
    @IBOutlet var numberOfTimesBottom: NSLayoutConstraint!
    @IBOutlet var numberOfTimesTop: NSLayoutConstraint!

    @IBOutlet var bismllahTitle: UILabel!
    @IBOutlet var zikr: UILabel!
    @IBOutlet var fadl: UILabel!
    @IBOutlet var numberOfTimes: UILabel!

    @IBOutlet var separatorView: UIView!

    weak var delegate: ZikrTableViewCellDelegate?

    func configureUI(zikrModel: ZikrModel) {
        bismllahTitle.text = zikrModel.title
        bismllahView(hide: zikrModel.title == "")

        zikr.text = zikrModel.zikr
        zikrView(hide: zikrModel.zikr == "")

        fadl.text = zikrModel.fadl
        fadlView(hide: zikrModel.fadl == "")

        numberOfTimes.text = zikrModel.numberOfTimes
        numberOfTimesView(hide: zikrModel.numberOfTimes == "")
    }

    private func bismllahView(hide: Bool) {
        bismllahBottom.constant = hide ? 0 : 16
        bismllahTop.constant = hide ? 0 : 16
    }

    private func zikrView(hide: Bool) {
        zikrTop.constant = hide ? 0 : 16
        zikrBottom.constant = hide ? 0 : 16
    }

    private func fadlView(hide: Bool) {
        fadlTop.constant = hide ? 0 : 16
        fadlBottom.constant = hide ? 0 : 16
    }

    private func numberOfTimesView(hide: Bool) {
        numberOfTimesTop.constant = hide ? 0 : 16
        numberOfTimesBottom.constant = hide ? 0 : 16
    }
}
