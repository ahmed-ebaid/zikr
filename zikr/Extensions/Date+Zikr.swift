//
//  Date+Zikr.swift
//  zikr
//
//  Created by Ahmed Ebaid on 6/9/18.
//  Copyright © 2018 Ahmed Ebaid. All rights reserved.
//
import Foundation

extension Date {
    static var day: Int? {
        return getDateComponents().day
    }

    static var month: Int? {
        return getDateComponents().month
    }

    static var year: Int? {
        return getDateComponents().year
    }

    static func getFormattedDate(date: String, dateFormat: String = "dd-MM-yyyy") -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.date(from: date)!
    }

    static func getDateComponents(for date: Date = Date()) -> DateComponents {
        return Calendar.current.dateComponents([.day, .month, .year], from: date)
    }
}
