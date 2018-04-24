import Foundation

extension Date {
    static var month: Int? {
        return getDateComponentsFrom().month
    }

    static var year: Int? {
        get {
            return getDateComponentsFrom().year
        }
        set {
            self.year = newValue
        }
    }

    static var nextMonth: Int? {
        if let currentMonth = month {
            if currentMonth < 12 {
                return currentMonth + 1
            } else {
                if let currentYear = year {
                    nextYear = currentYear + 1
                }
                return 1
            }
        }
        return 0
    }

    static var nextYear: Int? {
        get {
            return year
        }
        set {
            year = newValue
        }
    }

    static func getTodayDate(with dateFormat: String = "dd-MM-yyyy") -> Date {
        let todaysDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        let todayString = dateFormatter.string(from: todaysDate as Date)
        return dateFormatter.date(from: todayString)!
    }

    static func getDateFromString(using stringDate: String, and dateFormat: String = "dd-MM-yyyy") -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.date(from: stringDate)!
    }

    static func getDateComponentsFrom(date: Date = Date()) -> DateComponents {
        let components = Set<Calendar.Component>([.day, .month, .year])
        return Calendar.current.dateComponents(components, from: date)
    }
}
