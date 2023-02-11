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

// MARK: HomeViewModel
public final class HomeViewModel: ManhattanViewModelProtocol {
    /// home show overlay.
    @Published var homeShowOverlay: Bool = false
    /**
        Init.

        - Parameter homeShowOverlay: home show overlay.
    */
    init(
        homeShowOverlay: Bool = false
    ) {
        self.homeShowOverlay = homeShowOverlay
    }
    /// get weather view model.
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
    /// get profile view model.
    func getProfileViewModel() -> ProfileViewModel {
        HomeFactory().getProfileViewModel()
    }
    /// get task board view model.
    func getTaskBoardViewModel() -> TaskBoardViewModel {
        HomeFactory().getTaskBoardViewModel()
    }
    /**
        Set sync.

        - Parameter app: app environment.
    */
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
