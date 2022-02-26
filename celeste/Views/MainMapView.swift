//
//  MainMapView.swift
//  celeste
//
//  Created by Sally Lee on 2/26/22.
//

import Foundation
import SwiftUI
import MapKit

class Coordinator: NSObject, MKMapViewDelegate {
    
    var control: MainMapView
    
    init(_ control: MainMapView) {
        self.control = control
    }
    
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        
        if let annotationView = views.first {
            if let annotation = annotationView.annotation {
                if annotation is MKUserLocation {
                    
                    let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
                    mapView.setRegion(region, animated: true)
                    
                }
            }
        }
        
    }
}

struct MainMapView: UIViewRepresentable {
    
    let places: [Place]
    var centerCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 40.7318046, longitude: -74.00454929999999)
    var regionNYC: MKCoordinateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 40.75251018277572, longitude: -73.97984077693457),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.2)
    )
    func makeUIView(context: Context) -> MKMapView {
        let map = MKMapView()
//        map.centerCoordinate = centerCoordinate
        map.setRegion(regionNYC, animated: true)
        map.showsUserLocation = true
        map.delegate = context.coordinator
        return map
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<MainMapView>) {
        //
        updateAnnotations(from: uiView)
    }
    
    private func updateAnnotations(from mapView: MKMapView) {
        mapView.removeAnnotations(mapView.annotations)
        let annotations = self.places.map(PlaceAnnotation.init)
        mapView.addAnnotations(annotations)
    }
    
}
