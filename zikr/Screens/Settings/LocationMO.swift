import CoreData

class LocationMO : NSManagedObject {
    @NSManaged var latitude: NSNumber?
    @NSManaged var longitude: NSNumber?
    @NSManaged var city: String?
    @NSManaged var state: String?
    @NSManaged var country: String?
    @NSManaged var timestamp: Date?
    
    static func equals(lhs: LocationMO, rhs: LocationMO) -> Bool {
        return lhs.city == rhs.city && lhs.state == rhs.state && lhs.country == rhs.country
    }
}
