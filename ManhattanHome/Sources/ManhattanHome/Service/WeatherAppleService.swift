//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 18/12/22.
//

import WeatherKit
import CoreLocation
import SwiftUI
import OSLog

final class WeatherAppleService: ObservableObject {
    @Published var weatherService: WeatherService?
    @Published var weather: Weather?
    @Published var hourWeather: [HourWeather]?
    @Published var dayWeather: [DayWeather]?
    @Published var temperature: String?
    
    init(
        weatherService: WeatherService? = nil,
        weather: Weather? = nil,
        hourWeather: [HourWeather]? = nil,
        dayWeather: [DayWeather]? = nil,
        temperature: String? = nil
    ) {
        self.weatherService = weatherService
        self.weather = weather
        self.hourWeather = hourWeather
        self.dayWeather = dayWeather
        self.temperature = temperature
    }
    
    @MainActor
    func getWeatherForLocation(
        location: CLLocation
    ) async throws {
        do {
            weather = try await weatherService?.weather(
                for: location
            )
            hourWeather = getHourlyWeatherData(
                weather: weather
            )
            dayWeather = getDailyForecast(
                weather: weather
            )
            temperature = getWeatherTemperatureFormatted(
                weather: weather
            )
        } catch {
            os_log(
                .debug,
                "\(error.localizedDescription)"
            )
        }
    }
    
    func getHourlyWeatherData(
        weather: Weather?
    ) -> [HourWeather] {
        if let weather {
            return Array(
                weather.hourlyForecast.filter { hourlyWeather in
                    hourlyWeather.date.timeIntervalSince(Date()) >= 0
                }.prefix(24)
            )
        } else {
            return []
        }
    }
    
    func getDailyForecast(
        weather: Weather?
    ) -> [DayWeather] {
        weather?.dailyForecast.forecast ?? []
    }
    
    func getWeatherTemperatureFormatted(
        weather: Weather?
    ) -> String {
        weather?.currentWeather.temperature.formatted() ?? ""
    }
}
