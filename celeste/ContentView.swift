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
    @State private var places: [Place] = [Place]()
    @State private var tapped: Bool = false
    
    let dateFormatter = DateFormatter()
    
    @State private var filterByCategory = false
    @State private var filterByDate = false
    @State var category = "none"
    @State var date = Date()
    
    var categories = ["none", "eat", "drink", "coffee", "sightsee"]
    
    init() {
        dateFormatter.dateFormat = "yyyy-MM-dd"
    }
    
    var filteredPlaces: [Place] {
        places.filter { place in
            (
                (!filterByCategory || category == place.category) && (!filterByDate || place.date != "" && Calendar.current.isDate(date, equalTo: dateFormatter.date(from: place.date)!, toGranularity: Calendar.Component.day))
            )
        }
    }
    
    func getPlaces() {
        for placeInput in placeInputs {
            //            print("Place Input: ", placeInput)
            var placemark: MKPlacemark?
            getMKPlacemarkFromName(name: placeInput.name, completion: {
                result in
                switch result {
                case .success(let resultPlacemark):
                    placemark = resultPlacemark
                    //                    print("found placemark: ", placemark!)
                    places.append(Place(placemark: placemark!, placeInput: placeInput))
                    //                    print("current places: ", places)
                case .failure(let error):
                    print(error)
                }
            })
        }
    }
    
    func getMKPlacemarkFromName(name: String, completion: @escaping (Result<MKPlacemark, Error>) -> Void) {
        let request = MKLocalSearch.Request()
        let searchTerm = name + " New York NYC" // forcing search to include NYC
        request.naturalLanguageQuery = searchTerm
        // Include only point of interest results. This excludes results based on address matches.
        request.resultTypes = .pointOfInterest
        // Center around NYC
        request.region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 40.75251018277572, longitude: -73.97984077693457),
            span: MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3)
        )
        request.resultTypes = .pointOfInterest
        
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            guard let response = response, response.mapItems.count > 0, error == nil else {
                print("*******Search errored out for \(searchTerm): ", error!)
                completion(.failure(error!))
                return
            }
            let mapItems = response.mapItems
            //            print("Found mapItems: ", mapItems)
            if mapItems.count > 1 {
                //                print("Found more than 1 search result for \(searchTerm), using first in list for now.")
                //                print("Full list: ", mapItems)
            }
            completion(.success(mapItems[0].placemark))
        }
    }
    
    func calculateOffset() -> CGFloat {
        if self.places.count > 0 && !self.tapped {
            return UIScreen.main.bounds.size.height - UIScreen.main.bounds.size.height / 4
        }
        else if self.tapped {
            return 0
        } else {
            return UIScreen.main.bounds.size.height
        }
    }
    
    var body: some View {
        VStack {
            VStack {
                Toggle(isOn: $filterByCategory) {
                    Text("Filter by category")
                }
                if(filterByCategory) {
                    HStack {
                        Text("Category")
                        Spacer()
                        Picker(selection: $category, label: Text("Categories")) {
                            ForEach(categories, id: \.self) { category in
                                Text(category)
                            }
                        }
                    }
                    .padding([.leading])
                }
            }
            .padding([.horizontal])
            
            VStack {
                Toggle(isOn: $filterByDate) {
                    Text("Filter by date")
                }
                if(filterByDate) {
                    HStack {
                        Text("Date")
                        Spacer()
                        DatePicker("", selection: $date, displayedComponents: [.date])
                    }
                    .padding([.leading])
                }
            }
            .padding([.horizontal])
            
            HStack {
                EmptyView()
            }.frame(width: UIScreen.main.bounds.size.width, height: 30)
                .background(Color.gray)
                .contentShape(Rectangle())
                .gesture(TapGesture()
                            .onEnded {
                    self.tapped.toggle()
                }
                )
            
            ZStack(alignment: .top) {
                
                MainMapView(places: filteredPlaces).onAppear(perform: getPlaces)
                VStack {
                    PlacesList(places: filteredPlaces) {
                        // on tap
                        self.tapped.toggle()
                    }.animation(Animation.spring(), value: self.tapped).offset(y: calculateOffset())
                }
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
