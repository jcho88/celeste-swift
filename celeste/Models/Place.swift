//
//  Place.swift
//  celeste
//
//  Created by Sally Lee on 2/21/22.
//

import Foundation
import MapKit

struct Place: Codable, Identifiable {
    
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
    
    var iconName: String {
        switch category {
        case "eat":
            return "fork.knife"
        case "drink":
            return "d.circle"
        case "coffee":
            return "cup.and.saucer"
        case "sightsee":
            return "binoculars"
        default:
            return "heart"
        }
    }
        
    init(placemark: MKPlacemark, category: String, description: String?) {
        self.category = category
        self.description = description ?? nil
        self.name = placemark.name ?? ""
        self.title = placemark.title ?? ""
        self.latitude = placemark.coordinate.latitude
        self.longitude = placemark.coordinate.longitude
    }
    
    init(placemark: MKPlacemark, placeInput: PlaceInput) {
        self.name = placemark.name ?? placeInput.name
        self.title = placemark.title ?? ""
        self.category = placeInput.category
        self.description = placeInput.description ?? nil
        self.latitude = placemark.coordinate.latitude
        self.longitude = placemark.coordinate.longitude
    }

}
