//
//  AzkarData.swift
//  zikr
//
//  Created by Ahmed Ebaid on 6/9/18.
//  Copyright © 2018 Ahmed Ebaid. All rights reserved.
//
class AzkarData {
    static let sharedInstance = AzkarData()
    var zikrNotificationTimes: [ZikrNotificationTime]!

    private init() {}
}
