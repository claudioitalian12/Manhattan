//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 20/12/22.
//

import ManhattanCore
import WeatherKit
import SwiftUI
import OSLog

// MARK: WeatherViewModelProtocol
protocol WeatherViewModelProtocol: ManhattanViewModelProtocol {
    /// get weather for location.
    func getWeatherForLocation() async throws
    /**
        Get Consumption view model.

        - Parameter weatherService: weather service.
    */
    func getConsumptionViewModel(
        weatherService: WeatherAppleService
    ) async -> WhConsumptionViewModel
}

// MARK: WeatherViewModel
public final class WeatherViewModel: WeatherViewModelProtocol {
    /// location service.
    @Published var locationService: LocationService
    /// weather service.
    @Published var weatherService: WeatherAppleService
    /**
        Init.

        - Parameter locationService: location service.
    */
    init(
        locationService: LocationService,
        weatherService: WeatherAppleService
    ) {
        self.locationService = locationService
        self.weatherService = weatherService
    }
    /// get location.
    @MainActor
    func getLocation() async throws {
        do {
            try await locationService.getLocation()
        } catch {
            os_log(
                .debug,
                "\(error.localizedDescription)"
            )
            throw error
        }
    }
    /// get Weather for location.
    @MainActor
    func getWeatherForLocation() async throws {
        do {
            if let location = locationService.currentLocation {
                try await weatherService.getWeatherForLocation(
                    location: location
                )
            }
        } catch {
            os_log(
                .debug,
                "\(error.localizedDescription)"
            )
        }
    }
    /**
        Get Consumption view model.

        - Parameter weatherService: weather service.
    */
    func getConsumptionViewModel(
        weatherService: WeatherAppleService
    ) -> WhConsumptionViewModel {
        HomeFactory().getWhConsumptionViewModel(
            dateFormat: "yyyy-MM-dd HH:mm:ss",
            weatherService: weatherService,
            consumptionValue: ""
        )
    }
}
