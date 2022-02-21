//
//  Place.swift
//  celeste
//
//  Created by Sally Lee on 2/21/22.
//

import Foundation
import MapKit

struct Place: Codable {
    
//    let placemark: MKPlacemark
    
    var id: UUID {
        return UUID()
    }
    let name: String
    let title: String
    let description: String?
    let category: String
    let latitude: Double
    let longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
    }
        
    init(placemark: MKPlacemark, category: String, description: String?) {
        self.category = category
        self.description = description ?? nil
        self.name = placemark.name ?? ""
        self.title = placemark.title ?? ""
        self.latitude = placemark.coordinate.latitude
        self.longitude = placemark.coordinate.longitude
    }

}
