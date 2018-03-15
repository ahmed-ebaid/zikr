import UIKit
import MapKit
import CoreLocation

class ChangeLocationViewModel : NSObject, CLLocationManagerDelegate{
    private var locationManager = CLLocationManager()
    let userDefaults = UserDefaults.standard
    
    var favoritedLocations: [Location]? {
        get {
            if let data = userDefaults.object(forKey: "SavedLocations") as? NSData {
                let locations = NSKeyedUnarchiver.unarchiveObject(with: data as Data) as? [Location]
                return locations
            }
            return nil
        }
        set {
            userDefaults.setValue(NSKeyedArchiver.archivedData(withRootObject: newValue), forKey: "SavedLocations")
        }
    }
    
    func getCurrentLocation() {
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        
        self.locationManager.stopUpdatingLocation()

        // Set user's current location name
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarksArray, error in
            if placemarksArray != nil {
                let placemark = placemarksArray?.first
                
                let currentLocation = Location(coordinate: (placemark?.location)!, city: placemark?.locality! as! NSString, state: placemark?.administrativeArea as! NSString, country: placemark?.country as! NSString)
                self.addFavoritedLocation(location: currentLocation)
            }
        }
    }
    
    private func addFavoritedLocation(location: Location?) {
        var locations = self.favoritedLocations
        if locations == nil {
            locations = [Location]()
        } else {
            if let index = locations?.index(where: { $0.city == location?.city && $0.state == location?.state} ) {
                locations?.remove(at: index)
            }
        }
        if let location = location {
            locations?.append(location)
            self.favoritedLocations = locations
        }
    }
    
    func getLocationInfo(_ location: Location?) -> String {
        if let city = location?.city, let state = location?.state {
            return "\(city), \(state)"
        }
        
        if let city = location?.city, let country = location?.country {
            return "\(city), \(country)"
        }
        
        return ""
    }
    
}
