import CoreLocation
import MapKit
import UIKit
import CoreData

protocol ChangeLocationViewModelDelegate: class {
    func didRecieveLocation()
}

class ChangeLocationViewModel: NSObject, CLLocationManagerDelegate {
    weak var delegate: ChangeLocationViewModelDelegate?
    let coreDataManager = CoreDataManager.shared
    
    private var locationManager = CLLocationManager()
    
    var favoritedLocations: [LocationMO] {
        get {
            return coreDataManager.fetch(forEntity: "Locations", sortDescriptor: NSSortDescriptor(key: "timestamp", ascending: false)) as! [LocationMO]
        }
        set {
            for location in newValue {
                if !containsLocation(location) {
                    coreDataManager.insert(location)
                }
            }
            coreDataManager.save()
        }
    }
    
    func getLocation(using displayedLocation: String) -> LocationMO {
        let displayedLocationArray = displayedLocation.split(separator: ",")
        for location in favoritedLocations {
            guard let city = location.city, let state = location.state, let country = location.country else {
                continue
            }
            if city == displayedLocationArray[0].trimmingCharacters(in: .whitespaces) && (state == displayedLocationArray[1].trimmingCharacters(in: .whitespaces) || country == displayedLocationArray[1].trimmingCharacters(in: .whitespaces)) {
                return location
            }
        }
        return LocationMO(context: coreDataManager.managedObjectContext)
    }
    
    func getCurrentLocation() {
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    func addFavoritedLocation(location: LocationMO) {
        var locations = favoritedLocations
        
        if locations.isEmpty {
            favoritedLocations.append(location)
        } else {
            if let index = locations.index(where: { ($0.city == location.city && $0.state == location.state) || ($0.city == location.city && $0.country == location.country) }) {
                locations.remove(at: index)
            }
            
            locations.insert(location, at: 0)
            favoritedLocations = locations
        }
    }
    
    func getLocationInfo(_ location: LocationMO) -> String {
        if let city = location.city, let state = location.state {
            return "\(city), \(state)"
        }
        
        if let city = location.city, let country = location.country {
            return "\(city), \(country)"
        }
        
        return ""
    }
    
    // Mark Core Location Delegate Method
    func locationManager(_: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        
        locationManager.stopUpdatingLocation()
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarksArray, _ in
            if placemarksArray != nil {
                guard let placemark = placemarksArray?.first else {
                    return
                }
                
                let coordinate = placemark.location?.coordinate
                let latitude = coordinate?.latitude
                let longitude = coordinate?.longitude
                let city = placemark.locality
                let state = placemark.administrativeArea
                let country = placemark.country
                
                let newLocation = LocationMO(context: self.coreDataManager.managedObjectContext)
                newLocation.latitude = latitude as NSNumber?
                newLocation.longitude = longitude as NSNumber?
                newLocation.city = city
                newLocation.state = state
                newLocation.country = country
                newLocation.timestamp = Date()
                
                self.addFavoritedLocation(location: newLocation)
                self.delegate?.didRecieveLocation()
            }
        }
    }
    
    func containsLocation(_ location: LocationMO) -> Bool {
        var exists = true
        for favoriteLocation in favoritedLocations {
            exists = exists && LocationMO.equals(lhs: favoriteLocation, rhs: location)
        }
        return exists
    }
}
