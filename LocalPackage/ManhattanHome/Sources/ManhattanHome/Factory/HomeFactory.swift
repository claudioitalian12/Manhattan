//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 18/12/22.
//

import ManhattanCore
import RealmSwift
import WeatherKit
import SwiftUI

// MARK: HomeFactoryProtocol
protocol HomeFactoryProtocol {
    /// get home view model.
    func getHomeViewModel() -> HomeViewModel
    /// get weather view model.
    func getWeatherViewModel(
        locationService: LocationService,
        weatherService: WeatherAppleService
    ) -> WeatherViewModel
    /// get wh consumption view model.
    func getWhConsumptionViewModel(
        dateFormat: String,
        weatherService: WeatherAppleService,
        consumptionValue: String
    ) -> WhConsumptionViewModel
}

// MARK: HomeFactory
class HomeFactory: HomeFactoryProtocol {
    /// get home view model.
    func getHomeViewModel() -> HomeViewModel {
        HomeViewModel()
    }
    /**
        Get weather view model.

        - Parameter locationService: location service.
        - Parameter weatherService: weather service.
    */
    func getWeatherViewModel(
        locationService: LocationService,
        weatherService: WeatherAppleService
    ) -> WeatherViewModel {
        WeatherViewModel(
            locationService: locationService,
            weatherService: weatherService
        )
    }
    /**
        Get weather view model.

        - Parameter dataFormat: data format.
        - Parameter weatherService: weather service.
        - Parameter consumptionValue: consumption value.
    */
    func getWhConsumptionViewModel(
        dateFormat: String,
        weatherService: WeatherAppleService,
        consumptionValue: String
    ) -> WhConsumptionViewModel {
        WhConsumptionViewModel(
            dateFormat: dateFormat,
            weatherService: weatherService,
            consumptionValue: consumptionValue
        )
    }
    /// get profile view model.
    func getProfileViewModel() -> ProfileViewModel {
        ProfileViewModel()
    }
    /// get list view model.
    func getListViewModel() -> EventListViewModel {
        EventListViewModel()
    }
}
