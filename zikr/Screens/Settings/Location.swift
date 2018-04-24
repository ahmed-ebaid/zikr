import CoreLocation

class Location: NSObject, NSSecureCoding {
    let latitude: Double?
    let longitude: Double?
    let clLocation: CLLocation?
    let city: NSString?
    let state: NSString?
    let country: NSString?

    static var supportsSecureCoding: Bool = true

    init(clLocation: CLLocation?, city: NSString?, state: NSString?, country: NSString?) {
        self.clLocation = clLocation
        self.city = city
        self.state = state
        self.country = country
    }

    required init?(coder aDecoder: NSCoder) {
        clLocation = aDecoder.decodeObject(of: CLLocation.self, forKey: "coordinate")
        city = aDecoder.decodeObject(of: NSString.self, forKey: "city")
        state = aDecoder.decodeObject(of: NSString.self, forKey: "state")
        country = aDecoder.decodeObject(of: NSString.self, forKey: "country")
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(clLocation, forKey: "coordinate")
        aCoder.encode(city, forKey: "city")
        aCoder.encode(state, forKey: "state")
        aCoder.encode(country, forKey: "country")
    }
}

