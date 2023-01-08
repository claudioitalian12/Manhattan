//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 18/12/22.
//

import ManhattanCore
import CoreLocation
import RealmSwift
import WeatherKit
import SwiftUI

public final class HomeViewModel: ManhattanViewModelProtocol {
    @Published var homeShowOverlay: Bool = false
    
    init(
        homeShowOverlay: Bool = false
    ) {
        self.homeShowOverlay = homeShowOverlay
    }
    
    func getWeatherViewModel() -> WeatherViewModel {
        HomeFactory().getWeatherViewModel(
            locationService: LocationService(
                locationService: CLLocationManager()
            ),
            weatherService: WeatherAppleService(
                weatherService: WeatherService.shared,
                weather: nil
            )
        )
    }
    
    func getProfileViewModel() -> ProfileViewModel {
        HomeFactory().getProfileViewModel()
    }
    
    func getTaskBoardViewModel() -> TaskBoardViewModel {
        HomeFactory().getTaskBoardViewModel()
    }
    
    @MainActor
    func setSync(
        app: AppEnvironment
    ) async throws {
        do {
            try await app.setSync()
        } catch {
            throw error
        }
    }
}
