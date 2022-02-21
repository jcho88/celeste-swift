//
//  PlacesList.swift
//  celeste
//
//  Created by Justin Cho on 2/21/22.
//

import SwiftUI

struct PlacesList: View {
    var body: some View {
        NavigationView {
            List (places) { place in
                NavigationLink {
                    PlaceDetail()
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
        PlacesList()
    }
}
