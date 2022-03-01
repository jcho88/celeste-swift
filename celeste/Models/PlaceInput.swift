//
//  PlaceInput.swift
//  celeste
//
//  Created by Sally Lee on 2/21/22.
//

import Foundation
import MapKit

struct PlaceInput: Codable {
    let name: String
    let category: String
    let description: String?
    let date: String?
}
