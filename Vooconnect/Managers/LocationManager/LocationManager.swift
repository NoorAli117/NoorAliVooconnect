//
//  LocationManager.swift
//  Vooconnect
//
//  Created by Online Developer on 27/03/2023.
//

import Foundation
import CoreLocation
import Combine

/// LocationManager to update the current user location in DB

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {

    private let locationManager = CLLocationManager()

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        logger.error("Status: \(status)", category: .location)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coordinate = locations.first?.coordinate else { return }
        updateUserLocation(coordinate: coordinate)
    }
    
    /// Update user location
    /// - Parameters:
    ///   - latitude: latitude
    ///   - longitude: longitude
    func updateUserLocation(coordinate: CLLocationCoordinate2D) {
        let params: [String: Any] = [
            "lat": coordinate.latitude,
            "lon": coordinate.longitude
        ]
        NetworkManager.makeEndpointCall(fromEndpoint: .updateUserLocation, withDataType: NilModel.self, parameters: params) { result in
            switch result {
            case .success(_):
                logger.error("Successfully updated location.", category: .location)
            case .failure(let error):
                logger.error("Error Update Location: \(error.localizedDescription)", category: .location)
            }
        }
    }
}
