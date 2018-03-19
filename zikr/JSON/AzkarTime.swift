import SwiftyJSON

struct AzkarTime {
    let timings: Timings
    let date: Date
    
    static func fromJSON(_ json: JSON) throws -> AzkarTime {
        guard let timings = json["timings"].dictionaryObject, let date = json["date"]["gregorian"]["date"].string else {
            throw ClientError.parsingError(description: "Error parsing JSON")
        }
        
        let azkarTimes = Timings(Fajr: timings["Fajr"] as! String, Asr: timings["Asr"] as! String)
        
        return AzkarTime(timings: azkarTimes, date: Date.getDateFromString(using: date))
    }
    
    static func arrayFromJSON(_ json: JSON) throws -> [AzkarTime] {
        var azkarTimes: [AzkarTime] = []
        
        guard let data = json["data"].array else {
            throw ClientError.parsingError(description: "Failure parsing data from end point")
        }
        
        try data.forEach { try azkarTimes.append(AzkarTime.fromJSON($0)) }
        
        let todaysDate = Date()
        let todaysComponents = Date.getDateComponentsFrom(date: todaysDate)
        
        return azkarTimes.filter {
            let currentComponents = Date.getDateComponentsFrom(date: $0.date)
            
            if currentComponents.year == todaysComponents.year && currentComponents.month == todaysComponents.month {
                return currentComponents.day! >= todaysComponents.day!
            } else {
                return true
            }
        }
    }
}

struct Timings {
    let Fajr: String
    let Asr: String
}
