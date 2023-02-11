//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 18/12/22.
//

import CoreLocation

// MARK: LocationCheckedThrowingContinuation
public typealias LocationCheckedThrowingContinuation = CheckedContinuation<CLLocation, Error>

// MARK: LocationService
final class LocationService: NSObject, ObservableObject {
    /// current location.
    @Published var currentLocation: CLLocation?
    /// current city name.
    @Published var currentCityName: String?
    /// location service.
    private var locationService: CLLocationManager?
    /// location checked throwning continuation.
    private var locationCheckedThrowingContinuation: LocationCheckedThrowingContinuation?
    /**
        Init.

        - Parameter locationService: location service.
    */
    init(
        locationService: CLLocationManager
    ) {
        super.init()
        self.locationService = locationService
        self.locationService?.delegate = self
    }
    /// get location.
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
    /**
        Set City Name.

        - Parameter location: location.
    */
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

// MARK: Extension LocationService CLLocationManagerDelegate
extension LocationService: CLLocationManagerDelegate {
    /**
        Location manager did update.

        - Parameter locationManager: location manager.
        - Parameter didUpdateLocations: update locations.
    */
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
    /**
        Location manager fail.

        - Parameter locationManager: location manager.
        - Parameter didFailWithError: fail error.
    */
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
