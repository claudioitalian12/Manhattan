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

protocol WeatherViewModelProtocol: ManhattanViewModelProtocol {
    func getWeatherForLocation() async throws
    func getConsumptionViewModel(
        weatherService: WeatherAppleService
    ) async -> WhConsumptionViewModel
}

public final class WeatherViewModel: WeatherViewModelProtocol {
    @Published var locationService: LocationService
    @Published var weatherService: WeatherAppleService
    
    init(
        locationService: LocationService,
        weatherService: WeatherAppleService
    ) {
        self.locationService = locationService
        self.weatherService = weatherService
    }
    
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
