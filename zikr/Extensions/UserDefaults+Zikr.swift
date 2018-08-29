//
//  UserDefaults+Zikr.swift
//  zikr
//
//  Created by Ahmed Ebaid on 6/9/18.
//  Copyright © 2018 Ahmed Ebaid. All rights reserved.
//
import Foundation

extension UserDefaults {
    static func isFirstLaunch() -> Bool {
        let hasLaunchedBeforeFlag = "hasLaunchedBefore"
        let isFirstLaunch = !UserDefaults.standard.bool(forKey: hasLaunchedBeforeFlag)
        if isFirstLaunch {
            UserDefaults.standard.set(true, forKey: hasLaunchedBeforeFlag)
        }
        return isFirstLaunch
    }
}
