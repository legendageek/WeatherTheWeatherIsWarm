//
//  LocationService.swift
//  WeatherTheWeatherIsWarm
//
//  Created by Kirill Fukalov on 11.03.23.
//

import CoreLocation

//MARK: - Protocol

protocol LocationServiceDelegate: AnyObject {
    func didUpdateLocations(lat: CGFloat, lon:CGFloat)
    func didFailWithError(error: Error)
}

final class LocationService: NSObject {
    
    // MARK: - Internal var
    
    weak var delegate: LocationServiceDelegate?
    
    // MARK: - Private var
    
    private var locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    // MARK: - Internal methods
    
    func requestLocationUpdates() {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization() // alert show -> 45 stroky
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
        default:
            break
        }
    }
    
    func stopLocationUpdates() {
        locationManager.stopUpdatingLocation()
    }
}

// MARK: - CLLocationManagerDelegate

extension LocationService: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways: // user vibral keys
            manager.startUpdatingLocation()
        default: manager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coordinate = locations.first?.coordinate else { return }
        delegate?.didUpdateLocations(lat: coordinate.latitude, lon: coordinate.longitude)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        delegate?.didFailWithError(error: error)
    }
}
