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
    @StateObject var locationManager = LocationManager()
    let places: [Place]
    
    var body: some View {
        NavigationView {
            Map(coordinateRegion: $locationManager.region, showsUserLocation: true, annotationItems: places) {
                place in MapAnnotation(coordinate: place.coordinate) {
                    NavigationLink {
                        PlaceDetail(place: place)
                    } label: {
                        PlaceAnnotationView(place: place)
                    }
                }
            }.ignoresSafeArea(edges: .top).onAppear {
                locationManager.checkIfLocationServicesIsEnabled()
            }
        }
    }
}
