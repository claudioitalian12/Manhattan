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

// MARK: WeatherAppleService
final class WeatherAppleService: ObservableObject {
    /// weather service.
    @Published var weatherService: WeatherService?
    /// weather.
    @Published var weather: Weather?
    /// hour weather.
    @Published var hourWeather: [HourWeather]?
    /// day weather.
    @Published var dayWeather: [DayWeather]?
    /// temperature.
    @Published var temperature: String?
    /**
        Init.

        - Parameter weatherService: weather service.
        - Parameter weather: weather.
        - Parameter hourWeather: hour weather.
        - Parameter dayWeather: day weather.
        - Parameter temperature: temperature.
    */
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
    /**
        Get Weather for location.

        - Parameter location: location.
    */
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
    /**
        Get Hourly Weather Data.

        - Parameter weather: weather.
    */
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
    /**
        Get Daily Forecast.

        - Parameter weather: weather.
    */
    func getDailyForecast(
        weather: Weather?
    ) -> [DayWeather] {
        weather?.dailyForecast.forecast ?? []
    }
    /**
        Get Weather temperature format.

        - Parameter weather: weather.
    */
    func getWeatherTemperatureFormatted(
        weather: Weather?
    ) -> String {
        weather?.currentWeather.temperature.formatted() ?? ""
    }
}
