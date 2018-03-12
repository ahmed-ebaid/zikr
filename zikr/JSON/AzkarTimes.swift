import SwiftyJSON

struct AzkarTimes {
    let timings: Timings
    let date: Date
    
    static func fromJSON(_ json: JSON) throws -> AzkarTimes {
        guard let timings = json["timings"].dictionaryObject, let date = json["date"]["gregorian"]["date"].string else {
            throw ClientError.parsingError(description: "Error parsing JSON")
        }
        
        let azkarTimes = Timings(Fajr: timings["Fajr"] as! String, Asr: timings["Asr"] as! String)
        
        return AzkarTimes(timings: azkarTimes, date: Date.getDateFromString(using: date))
    }
    
    static func arrayFromJSON(_ json: JSON) throws -> [AzkarTimes] {
        var azkarTimes: [AzkarTimes] = []
        
        guard let data = json["data"].array else {
            throw ClientError.parsingError(description: "Failure parsing data from end point")
        }
        
        try data.forEach { try azkarTimes.append(AzkarTimes.fromJSON($0)) }
        
        let todaysDate = Date()
        
        return azkarTimes.filter { $0.date >= todaysDate }
    }
    
}

struct Timings {
    let Fajr: String
    let Asr: String
}
