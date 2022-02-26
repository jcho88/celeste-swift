//
//  PlaceAnnotation.swift
//  celeste
//
//  Created by Sally Lee on 2/26/22.
//

import Foundation
import MapKit
import UIKit


final class PlaceAnnotation: NSObject, MKAnnotation {
    let title: String?
    let category: String?
    let coordinate: CLLocationCoordinate2D

    init(place: Place) {
        self.title = place.name
        self.category = place.category
        self.coordinate = place.coordinate
    }
}
