//
//  PlaceDetail.swift
//  celeste
//
//  Created by Justin Cho on 2/21/22.
//

import SwiftUI

struct PlaceDetail: View {
    
    var place: Place
//    @State private var date: Date = Date();
//    let dateFormatter = DateFormatter();
//    @State private var image = Image()
    
    var body: some View {
        ScrollView {
            MapView(coordinate: place.coordinate)
                .ignoresSafeArea(edges: .top)
                .frame(height: 300)
            
            CircleImage()
                .offset(y: -130)
                .padding(.bottom, -130)
            
            VStack(alignment: .leading) {
                Text(place.name)
                    .font(.title)
                HStack {
                    Text(place.category)
                        .font(.subheadline)
                    Spacer()
                    Text(place.date)
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
                
                if(place.description != "") {
                    Divider()
                    Text("About " + place.name)
                        .font(.title2)
                    Text(place.description)
                        .font(.subheadline)
                }
            }
            .padding()
            
            Spacer()
        }
    }

}

struct PlaceDetail_Previews: PreviewProvider {
    static var previews: some View {
        PlaceDetail(place: placesSample[0])
    }
}
