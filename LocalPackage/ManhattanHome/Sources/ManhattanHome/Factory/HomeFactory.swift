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

protocol HomeFactoryProtocol {
    func getHomeViewModel() -> HomeViewModel
    
    func getWeatherViewModel(
        locationService: LocationService,
        weatherService: WeatherAppleService
    ) -> WeatherViewModel
    
    func getWhConsumptionViewModel(
        dateFormat: String,
        weatherService: WeatherAppleService,
        consumptionValue: String
    ) -> WhConsumptionViewModel
}

class HomeFactory: HomeFactoryProtocol {
    func getHomeViewModel() -> HomeViewModel {
        HomeViewModel()
    }
    
    func getWeatherViewModel(
        locationService: LocationService,
        weatherService: WeatherAppleService
    ) -> WeatherViewModel {
        WeatherViewModel(
            locationService: locationService,
            weatherService: weatherService
        )
    }
    
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
    
    func getProfileViewModel() -> ProfileViewModel {
        ProfileViewModel()
    }
    
    func getTaskBoardViewModel(
    ) -> TaskBoardViewModel {
        TaskBoardViewModel(
            homeShowOverlay: false,
            isLoading: false,
            segmentationSelection: .all
        )
    }
    
    func getListViewModel() -> EventListViewModel {
        EventListViewModel()
    }
}
