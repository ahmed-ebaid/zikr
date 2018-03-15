import CoreLocation

class Location : NSObject, NSSecureCoding {
    let coordinate: CLLocation?
    let city: NSString?
    let state: NSString?
    let country: NSString?
    
    static var supportsSecureCoding: Bool = true
    
    init(coordinate: CLLocation, city: NSString, state: NSString?, country: NSString) {
        self.coordinate = coordinate
        self.city = city
        self.state = state
        self.country = country
    }
    
    required init?(coder aDecoder: NSCoder) {
        coordinate = aDecoder.decodeObject(of:CLLocation.self, forKey: "coordinate")
        city = aDecoder.decodeObject(of:NSString.self, forKey: "city")
        state = aDecoder.decodeObject(of:NSString.self, forKey: "state")
        country = aDecoder.decodeObject(of:NSString.self, forKey: "country")
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(coordinate, forKey: "coordinate")
        aCoder.encode(city, forKey: "city")
        aCoder.encode(state, forKey: "state")
        aCoder.encode(country, forKey: "country")
    }
}

//extension Location : Equatable {
//    static func ==(lhs: Location, rhs: Location) -> Bool {
//        return lhs.coordinate == rhs.coordinate && lhs.city == rhs.city && lhs.state == rhs.state && lhs.country == rhs.country
//    }
//}

