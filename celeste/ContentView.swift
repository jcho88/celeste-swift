//
//  ContentView.swift
//  celeste
//
//  Created by Justin Cho on 2/21/22.
//

import SwiftUI
import MapKit

struct ContentView: View {
//    @ObservedObject var locationManager = LocationManager()
//    @State private var places: [Place] = [Place]()
//    @State private var search: String = ""
////    @State private var tapped: Bool = false
//
//    private func getPlaces() {
//        
//        let request = MKLocalSearch.Request()
//        request.naturalLanguageQuery = search
//        // Include only point of interest results. This excludes results based on address matches.
//        request.resultTypes = .pointOfInterest
//        request.region = MKRe
//
//        let search = MKLocalSearch(request: request)
//        search.start { (response, error) in
//            if let response = response {
//
//                let mapItems = response.mapItems
//                self.landmarks = mapItems.map {
//                    Landmark(placemark: $0.placemark)
//                }
//
//            }
//
//        }
//
//    }
    
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
