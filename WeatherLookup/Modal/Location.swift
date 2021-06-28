//
//  Location.swift
//  WeatherLookup
//
//  Created by Chenna on 6/26/21.
//

import Foundation
import MapKit
import AddressBookUI


public class Location: NSObject {
    public let name: String?
    
    // difference from placemark location is that if location was reverse geocoded,
    // then location point to user selected location
    public let location: CLLocation
    public let placemark: CLPlacemark
    public var address: String
    
    public init(name: String?, location: CLLocation? = nil, placemark: CLPlacemark, address: String) {
        self.name = name
        self.location = location ?? placemark.location!
        self.placemark = placemark
        self.address = address
    }
}


extension Location: MKAnnotation {
    @objc public var coordinate: CLLocationCoordinate2D {
        return location.coordinate
    }
    
    public var title: String? {
        return name ?? address
    }
}

extension CLPlacemark {
    
    func getAddress() -> String {
        
        var addressString = ""
        let allThestrings = [subThoroughfare,thoroughfare,locality,subLocality,administrativeArea,postalCode,country]
        
        for word in allThestrings {
            if (word ?? "")?.count ?? 0 > 0 {
                addressString.append( (addressString.count > 0 ? ", " : "" ) + (word ?? ""))
            }
        }
        return addressString
    }
}
