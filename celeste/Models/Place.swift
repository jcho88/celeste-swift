//
//  Place.swift
//  celeste
//
//  Created by Sally Lee on 2/21/22.
//

import Foundation
import MapKit

class Place: ObservableObject, Codable, Identifiable {
    
//    let placemark: MKPlacemark
    
    var id: UUID {
        return UUID()
    }
    let name: String
    let title: String
    let description: String
    let category: String
    let latitude: Double
    let longitude: Double
//    @Published var date: Date = Date()
    let date: String
    
    enum CodingKeys: CodingKey {
        case name
        case title
        case description
        case category
        case latitude
        case longitude
        case date
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        title = try container.decode(String.self, forKey: .title)
        description = try container.decode(String.self, forKey: .description)
        category = try container.decode(String.self, forKey: .category)
        latitude = try container.decode(Double.self, forKey: .latitude)
        longitude = try container.decode(Double.self, forKey: .longitude)
//        date = try container.decode(Date.self, forKey: .date)
        date = try container.decode(String.self, forKey: .date)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(title, forKey: .title)
        try container.encode(description, forKey: .description)
        try container.encode(category, forKey: .category)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
        try container.encode(date, forKey: .date)
    }
    
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
    
    init(placemark: MKPlacemark, placeInput: PlaceInput) {
        self.name = placemark.name ?? placeInput.name
        self.title = placemark.title ?? ""
        self.category = placeInput.category
        self.description = placeInput.description ?? ""
        self.latitude = placemark.coordinate.latitude
        self.longitude = placemark.coordinate.longitude
        self.date = placeInput.date ?? ""
    }

}
