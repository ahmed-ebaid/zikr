//
//  SettingsTableViewController.swift
//  zikr
//
//  Created by Ahmed Ebaid on 6/9/18.
//  Copyright © 2018 Ahmed Ebaid. All rights reserved.
//

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
