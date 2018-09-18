//
//  Location.swift
//  zikr
//
//  Created by Ahmed Ebaid on 6/9/18.
//  Copyright © 2018 Ahmed Ebaid. All rights reserved.
//
import CoreData
import CoreLocation
import MapKit
import UIKit

class Location: NSObject {
    static let DidChangeLocationNotification = NSNotification.Name("Location.didChangeLocationNotification")

    let coreDataManager = CoreDataManager.shared

    private var locationManager = CLLocationManager()

    var favoritedLocations: [LocationMO] {
        return coreDataManager.fetch(forEntity: "Locations", sortDescriptor: NSSortDescriptor(key: "timestamp", ascending: false)) as! [LocationMO]
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
        location.timestamp = Date()
        coreDataManager.save()
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

    private func isUniqueLocation(city: String, state: String, country: String) -> Bool {
        for location in favoritedLocations {
            if (location.city == city && location.state == state) || (location.city == city && location.country == country) {
                location.timestamp = Date()
                coreDataManager.save()
                return false
            }
        }
        return true
    }
}

extension Location: CLLocationManagerDelegate {
    func locationManager(_: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }

        locationManager.stopUpdatingLocation()
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarksArray, _ in
            if let placemark = placemarksArray?.first {
                guard let coordinate = placemark.location?.coordinate else {
                    return
                }

                let latitude = coordinate.latitude
                let longitude = coordinate.longitude
                guard let city = placemark.locality, let state = placemark.administrativeArea, let country = placemark.country else {
                    return
                }

                if self.isUniqueLocation(city: city, state: state, country: country) {
                    let newLocation = LocationMO(context: self.coreDataManager.managedObjectContext)
                    newLocation.latitude = latitude as NSNumber?
                    newLocation.longitude = longitude as NSNumber?
                    newLocation.city = city
                    newLocation.state = state
                    newLocation.country = country
                    newLocation.timestamp = Date()
                    self.coreDataManager.save()
                }
                NotificationCenter.default.post(name: Location.DidChangeLocationNotification, object: nil)
            }
        }
    }
}
