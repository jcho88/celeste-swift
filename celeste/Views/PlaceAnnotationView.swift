//
//  PlaceAnnotationView.swift
//  celeste
//
//  Created by Sally Lee on 2/26/22.
//

import Foundation
import MapKit
import SwiftUI

struct PlaceAnnotationView: View {
    var place: Place
    var body: some View {
        HStack(alignment: .bottom) {
            Image(systemName: place.iconName).symbolVariant(.fill)
                .foregroundColor(Color.red)
            Text(place.name).dynamicTypeSize(SwiftUI.DynamicTypeSize.xSmall).foregroundColor(Color.black)
        }.padding(5)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
            .overlay(
                Image(systemName: "arrowtriangle.down.fill")
                    .foregroundColor(Color.white)
                    .offset(y: 10), alignment: .bottom
            )
    }
}
