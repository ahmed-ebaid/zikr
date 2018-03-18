import UIKit
import MapKit
import CoreLocation

protocol ChangeLocationViewModelDelegate: class {
    func didRecieveLocation()
}

class ChangeLocationViewModel : NSObject, CLLocationManagerDelegate {
    weak var delegate: ChangeLocationViewModelDelegate?
    
    let userDefaults = UserDefaults.standard
    private var locationManager = CLLocationManager()
    var favoritedLocations: [Location] {
        get {
            if let data = userDefaults.object(forKey: "SavedLocations") as? NSData {
                let locations = NSKeyedUnarchiver.unarchiveObject(with: data as Data) as? [Location]
                return locations ?? []
            }
            return []
        }
        set {
            userDefaults.setValue(NSKeyedArchiver.archivedData(withRootObject: newValue), forKey: "SavedLocations")
        }
    }
    
    func getLocation(using displayedLocation: String) -> Location {
        let displayedLocationArray = displayedLocation.split(separator: ",")
        for location in favoritedLocations {
            guard let city = location.city, let state = location.state, let country = location.country else  {
                continue
            }
            if city as String == displayedLocationArray[0].trimmingCharacters(in: .whitespaces) && ( state as String == displayedLocationArray[1].trimmingCharacters(in: .whitespaces) || country as String == displayedLocationArray[1].trimmingCharacters(in: .whitespaces) ) {
                return location
            }
        }
        return Location(clLocation: nil, city: nil, state: nil, country: nil)
    }
    
    func getCurrentLocation() {
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    func addFavoritedLocation(location: Location) {
        var locations = self.favoritedLocations
        
        if locations.isEmpty {
            self.favoritedLocations.append(location)
        } else {
            if let index = locations.index(where: { ($0.city == location.city && $0.state == location.state) || ($0.city == location.city && $0.country == location.country) } ) {
                locations.remove(at: index)
            }
            
            locations.insert(location, at: 0)
            self.favoritedLocations = locations
        }
    }
    
    func getLocationInfo(_ location: Location) -> String {
        if let city = location.city, let state = location.state {
            return "\(String(describing: city)), \(String(describing: state))"
        }
        
        if let city = location.city, let country = location.country {
            return "\(String(describing: city)), \(String(describing: country))"
        }
        
        return ""
    }
    
    //Mark Core Location Delegate Method
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        
        self.locationManager.stopUpdatingLocation()
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarksArray, error in
            if placemarksArray != nil {
                guard let placemark = placemarksArray?.first else {
                    return
                }
                
                let coordinate = placemark.location
                let city = placemark.locality as NSString?
                let state = placemark.administrativeArea as NSString?
                let country = placemark.country as NSString?
                
                self.addFavoritedLocation(location: Location(clLocation: coordinate, city: city, state: state, country: country))
                self.delegate?.didRecieveLocation()
            }
        }
    }
}
