//
//  SettingsTableViewController.swift
//  zikr
//
//  Created by Ahmed Ebaid on 6/9/18.
//  Copyright © 2018 Ahmed Ebaid. All rights reserved.
//

import Foundation

fileprivate let defaultCalculationMethodIndex = 2

class CalculationMethodViewModel {
    let userDefaults = UserDefaults.standard
    lazy var calculationMethods = [
        ("Jafari - Ithna Ashari.", 0),
        ("Karachi - University of Islamic Sciences.", 1),
        ("ISNA - Islamic Society of North America.", 2),
        ("MWL - Muslim World League.", 3),
        ("Mecca - Umm al-Qura.", 4),
        ("Egyptian General Authority of Survey.", 5),
        ("University of Tehran - Institute of Geophysics.", 7),
        ("Algerian Minister of Religious Affairs and Wakfs.", 8),
        ("Institute of Geophysics.", 9),
        (" Wakfs.", 10),
        ("Geophysics.", 11),
        (" AB", 12),
        (" CD.", 13),
        ("EF.", 14),
        (" GH.", 15),
        (" IJ.", 16),
        ("KL.", 17),
        (" MN.", 18),
    ]

    var calculationMethod: Int {
        return userDefaults.integer(forKey: "CalculationMethod")
    }

    func setCalculationMethod(calculationMethod: String = "ISNA - Islamic Society of North America.") {
        userDefaults.set(findIndexOfCalculationMethod(calculationMethod), forKey: "CalculationMethod")
    }

    private func findIndexOfCalculationMethod(_ calculationMethod: String) -> Int {
        for tuple in calculationMethods {
            if tuple.0 == calculationMethod {
                return tuple.1
            }
        }
        return defaultCalculationMethodIndex
    }
}
