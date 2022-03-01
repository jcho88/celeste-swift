//
//  PlacesList.swift
//  celeste
//
//  Created by Justin Cho on 2/21/22.
//

import SwiftUI
import MapKit

struct PlacesList: View {
    
    let places: [Place]
    var onTap: () -> ()
    
    var body: some View {
        NavigationView {
            List (places) { place in
                NavigationLink {
                    PlaceDetail(place: place)
                } label: {
                    PlacesRow(place: place)
                }
            }
            .navigationTitle("Places")
        }
    }
}

struct PlacesList_Previews: PreviewProvider {
    static var previews: some View {
        PlacesList(places: [Place(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0)), placeInput: placeInputs[0]),
                            Place(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0)), placeInput: placeInputs[1])], onTap: {} )
    }
}
