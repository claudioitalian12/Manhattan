//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 20/12/22.
//

import ManhattanCore
import CoreLocation
import WeatherKit
import SwiftUI

struct WeatherView: View {
    @Environment(\.appEnvironmentValue) var appEnvironment: AppEnvironment
    @StateObject var viewModel: WeatherViewModel = WeatherViewModel(
        locationService: LocationService(
            locationService: CLLocationManager()
        ),
        weatherService: WeatherAppleService(
            weatherService: WeatherService.shared,
            weather: nil
        )
    )
    @State private var isLoading = true
    
    var body: some View {
        ScrollView(
            showsIndicators: false
        ) {
            LazyVStack {
                Text(viewModel.locationService.currentCityName ?? "")
                    .customTextWeatherView()
                Text(viewModel.weatherService.temperature ?? "")
                weatherViewSubView(
                    weatherService: viewModel.weatherService
                )
                Spacer(
                    minLength: 20.0
                )
            }
        }
        .refreshable {
            isLoading.toggle()
        }
        .redacted(
            reason: isLoading ? .placeholder:[]
        )
        .task(
            id: isLoading
        ) {
            if isLoading == true {
                Task {
                    try await loadLocation()
                    try await loadWeather()
                    isLoading.toggle()
                }
            }
        }
    }
    
    @ViewBuilder
    private func weatherViewSubView(
        weatherService: WeatherAppleService
    ) -> some View {
        KwhConsumptionView<WhConsumptionViewModel>(
            viewModel: viewModel.getConsumptionViewModel(
                weatherService: weatherService
            )
        )
        HourlyForcastView(
            viewModel: weatherService
        )
        
        TenDayForcastView(
            viewModel: weatherService
        )
    }
    
    private func loadLocation() async throws {
        do {
            try await viewModel.getLocation()
        } catch {
            throw error
        }
    }
    
    private func loadWeather() async throws {
        do {
            try await viewModel.getWeatherForLocation()
        } catch {
            throw error
        }
    }
}
