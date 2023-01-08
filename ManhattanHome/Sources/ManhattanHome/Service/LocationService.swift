//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 18/12/22.
//

import CoreLocation

public typealias LocationCheckedThrowingContinuation = CheckedContinuation<CLLocation, Error>

final class LocationService: NSObject, ObservableObject {
    @Published var currentLocation: CLLocation?
    @Published var currentCityName: String?
    private var locationService: CLLocationManager?
    private var locationCheckedThrowingContinuation: LocationCheckedThrowingContinuation?

    init(
        locationService: CLLocationManager
    ) {
        super.init()
        self.locationService = locationService
        self.locationService?.delegate = self
    }
    
    @MainActor
    func getLocation() async throws {
        let location = try await withCheckedThrowingContinuation(
            { [weak self] (continuation: LocationCheckedThrowingContinuation) in
                guard let self else {
                    return
                }
                
                self.locationCheckedThrowingContinuation = continuation
                self.locationService?.desiredAccuracy = kCLLocationAccuracyBest
                self.locationService?.distanceFilter = kCLDistanceFilterNone
                self.locationService?.requestAlwaysAuthorization()
                self.locationService?.startUpdatingLocation()
            }
        )
        
        self.setCityName(
            location: location
        )
        self.currentLocation = location
    }
    
    private func setCityName(
        location: CLLocation
    ) {
        let geocoder = CLGeocoder()
        
        geocoder.reverseGeocodeLocation(
            location) { placeMakers, error in
                guard let placeMakers,
                      let placeMaker = placeMakers.first else {
                    return
                }
                self.currentCityName = placeMaker.locality
            }
    }
}

extension LocationService: CLLocationManagerDelegate {
    func locationManager(
        _: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        guard let location = locations.last else {
            return
        }
        locationCheckedThrowingContinuation?.resume(
            returning: location
        )
        locationCheckedThrowingContinuation = nil
    }
    
    func locationManager(
        _: CLLocationManager,
        didFailWithError error: Error
    ) {
        switch self.locationService?.authorizationStatus {
        case .notDetermined:
            break
        default:
            locationCheckedThrowingContinuation?.resume(
                throwing: error
            )
            locationCheckedThrowingContinuation = nil
        }
    }
}
