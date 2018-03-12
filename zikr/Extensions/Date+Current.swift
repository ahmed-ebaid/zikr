import Foundation

extension Date {
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
}
