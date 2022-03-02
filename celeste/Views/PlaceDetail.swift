//
//  PlaceDetail.swift
//  celeste
//
//  Created by Justin Cho on 2/21/22.
//

import SwiftUI

struct PlaceDetail: View {
    
    var place: Place
    @State var businesses = Businesses()
    @State var address = [String]()
    @State var imageUrl = String()
    
    var body: some View {
        ScrollView {
            MapView(coordinate: place.coordinate)
                .ignoresSafeArea(edges: .top)
                .frame(height: 300)
            
            AsyncImage(url: URL(string: imageUrl)) { image in
                image.resizable()
                .clipShape(Circle())
                .overlay {
                    Circle().stroke(.white, lineWidth: 4)
                }
                .shadow(radius: 7)
                
                
            } placeholder: {
                ProgressView()
            }
            .frame(width: 250, height: 250)
            .offset(y: -130)
            
            VStack() {
                Text(place.name)
                    .font(.title)
                    .padding([.bottom])
                
                ForEach(address, id: \.self) { add in
                    Text(add)
                }
                
                HStack {
                    Text(place.category)
                        .font(.subheadline)
                    Spacer()
                    Text(place.date)
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding([.top])
            }
            .padding()
            .offset(y: -130)
            
            VStack(alignment: .leading) {
                if(place.description != "") {
                    Divider()
                    Text("About " + place.name)
                        .font(.title2)
                    Text(place.description)
                        .font(.subheadline)
                }
            }
            .padding()
            .offset(y: -130)
        }
        .onAppear() {
            YelpApi().getBusinessByName(name: place.name, latitude: place.latitude, longitude: place.longitude) { (data) in
                self.businesses = data
                address = businesses.businesses[0].location.display_address
                imageUrl = businesses.businesses[0].image_url
            }
        }
    }

}

struct PlaceDetail_Previews: PreviewProvider {
    static var previews: some View {
        PlaceDetail(place: placesSample[0])
    }
}
