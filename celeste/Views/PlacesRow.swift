//
//  PlacesRow.swift
//  celeste
//
//  Created by Justin Cho on 2/21/22.
//

import SwiftUI

struct PlacesRow: View {
    
    var place: Place
    
    var body: some View {
        HStack {
            Text(place.name)
            
            Spacer()
        }
    }
}

struct PlacesRow_Previews: PreviewProvider {
    static var previews: some View {
        PlacesRow(place: places[0])
    }
}
