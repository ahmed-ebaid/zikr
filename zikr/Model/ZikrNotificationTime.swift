//
//  ZikrNotificationTime.swift
//  zikr
//
//  Created by Ahmed Ebaid on 6/9/18.
//  Copyright © 2018 Ahmed Ebaid. All rights reserved.
//
import SwiftyJSON

struct ZikrNotificationTime {
    let timings: FajrAndAsrTimings
    let date: Date

    static func fromJSON(_ json: JSON) throws -> ZikrNotificationTime {
        guard let timings = json["timings"].dictionaryObject, let date = json["date"]["gregorian"]["date"].string else {
            throw ClientError.parsingError(description: "Error parsing JSON")
        }

        let fajrAndAsrTimings = FajrAndAsrTimings(fajr: timings["Fajr"] as! String, asr: timings["Asr"] as! String)

        return ZikrNotificationTime(timings: fajrAndAsrTimings, date: Date.getFormattedDate(date: date))
    }

    static func arrayFromJSON(_ json: JSON) throws -> [ZikrNotificationTime] {
        var zikrNotificationTimes: [ZikrNotificationTime] = []

        guard let data = json["data"].array else {
            throw ClientError.parsingError(description: "Failure parsing data from end point")
        }

        try data.forEach { try zikrNotificationTimes.append(ZikrNotificationTime.fromJSON($0)) }

        let todaysDate = Date()
        let todaysComponents = Date.getDateComponents(for: todaysDate)

        return zikrNotificationTimes.filter {
            let currentComponents = Date.getDateComponents(for: $0.date)

            if currentComponents.year == todaysComponents.year && currentComponents.month == todaysComponents.month {
                return currentComponents.day! >= todaysComponents.day!
            } else {
                return true
            }
        }
    }
}

struct FajrAndAsrTimings {
    let fajr: String
    let asr: String
}
