//
//  ContentView.swift
//  celeste
//
//  Created by Justin Cho on 2/21/22.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var places: [Place] = [Place]()
    
    func getPlaces() {
        for placeInput in placeInputs {
            print("Place Input: ", placeInput)
            var placemark: MKPlacemark?
            getMKPlacemarkFromName(name: placeInput.name, completion: {
                result in
                switch result {
                case .success(let resultPlacemark):
                    placemark = resultPlacemark
                    print("found placemark: ", placemark!)
                    places.append(Place(placemark: placemark!, placeInput: placeInput))
                    print("current places: ", places)
                case .failure(let error):
                    print(error)
                }
            })
        }
    }

    func getMKPlacemarkFromName(name: String, completion: @escaping (Result<MKPlacemark, Error>) -> Void) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = name
        // Include only point of interest results. This excludes results based on address matches.
        request.resultTypes = .pointOfInterest
        // Center around NYC
        request.region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 40.75251018277572, longitude: -73.97984077693457),
            span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        )
        
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            guard let response = response, response.mapItems.count > 0, error == nil else {
                print("Search errored out: ", error!)
                completion(.failure(error!))
                return
            }
            let mapItems = response.mapItems
            print("Found mapItems: ", mapItems)
            if mapItems.count > 1 {
                print("Found more than 1 search result, using first in list for now.")
            }
            completion(.success(mapItems[0].placemark))
        }
    }
    
    @State var businesses = Businesses()
    
    var body: some View {
        PlacesList(places: places).onAppear(perform: getPlaces)
        Text("Test")
            .onAppear() {
                YelpApi().getBusinessByName { (data) in
                    self.businesses = data
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
