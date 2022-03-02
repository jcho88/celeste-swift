//
//  LocationManager.swift
//  celeste
//
//  Created by Sally Lee on 2/21/22.
//

import Foundation
import MapKit

final class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var region: MKCoordinateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 40.73251018277572, longitude: -73.98984077693457),
        span: MKCoordinateSpan(latitudeDelta: 0.08, longitudeDelta: 0.08)
    )
    var locationManager: CLLocationManager?
    
    func checkIfLocationServicesIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager!.delegate = self
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        } else {
            print("ALERT: Location Services is not on.")
        }
    }
    
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else {
            return
        }
        
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("ALERT: Location is restricted, likely due to parental controls.")
        case .denied:
            print("ALERT: Location permission is denied.")
        case .authorizedAlways, .authorizedWhenInUse:
            print("Location is authorized.")
            if locationManager.location != nil {
                region = MKCoordinateRegion(center: locationManager.location!.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.08, longitudeDelta: 0.08))
            } else {
                break
            }
        @unknown default:
            break
        }
        
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}

//    @Published var location: CLLocation? = nil
    
    //    override init() {
    //
    //        super.init()
    //        self.locationManager.delegate = self
    //        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
    //        self.locationManager.distanceFilter = kCLDistanceFilterNone
    //        self.locationManager.requestWhenInUseAuthorization()
    //        self.locationManager.startUpdatingLocation()
    //
    //    }
    

//extension LocationManager: CLLocationManagerDelegate {
//
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        print(status)
//    }
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let location = locations.last else {
//            return
//        }
//
//        self.location = location
//    }
//
//}
