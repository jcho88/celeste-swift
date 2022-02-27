//
//  MainMapView.swift
//  celeste
//
//  Created by Sally Lee on 2/26/22.
//

import Foundation
import SwiftUI
import MapKit

struct MainMapView: View {
    let places: [Place]
    @State private var region = MKCoordinateRegion()
    var regionNYC: MKCoordinateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 40.75251018277572, longitude: -73.97984077693457),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.2)
    )
    
    var body: some View {
        NavigationView {
            Map(coordinateRegion: $region, annotationItems: places) {
                place in MapAnnotation(coordinate: place.coordinate) {
                    NavigationLink {
                        PlaceDetail(place: place)
                    } label: {
                        PlaceAnnotationView(place: place)
                    }
                }
            }.onAppear {
                region = regionNYC
            }
        }
    }
}
