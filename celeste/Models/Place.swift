//
//  Place.swift
//  celeste
//
//  Created by Sally Lee on 2/21/22.
//

import Foundation
import MapKit

struct Place {
    
    let placemark: MKPlacemark
    
    var description: String = ""
    var category: String = ""
    
    var id: UUID {
        return UUID()
    }
    
    var name: String {
        self.placemark.name ?? ""
    }
    
    var title: String {
        self.placemark.title ?? ""
    }
    
    var coordinate: CLLocationCoordinate2D {
        self.placemark.coordinate
    }
    
    init(placemark: MKPlacemark, category: String, description: String?) {
        self.placemark = placemark
        self.category = category
        if description != nil {
            self.description = description!
        }
    }
}
