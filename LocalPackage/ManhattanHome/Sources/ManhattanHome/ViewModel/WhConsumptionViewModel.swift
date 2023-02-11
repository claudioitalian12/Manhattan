//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 22/12/22.
//

import ManhattanCore
import WeatherKit
import SwiftUI
import CoreML

// MARK: WhConsumptionViewModelProtocol
protocol WhConsumptionViewModelProtocol: ManhattanViewModelProtocol {
    /// weather Service.
    var weatherService: WeatherAppleService { get set }
    /// consumption Value.
    var consumptionValue: String { get set }
    /// predictConsumption.
    func predictConsumption() throws
}

// MARK: WhConsumptionViewModel
public final class WhConsumptionViewModel: WhConsumptionViewModelProtocol {
    /// dateFormat.
    private let dateFormat: String
    /// weatherService.
    var weatherService: WeatherAppleService
    /// consumptionValue.
    @Published var consumptionValue: String
    /**
        Init.

        - Parameter dateFormat: date format.
        - Parameter weatherService: weather service.
        - Parameter consumptionValue: consumption value.
    */
    init(
        dateFormat: String,
        weatherService: WeatherAppleService,
        consumptionValue: String = ""
    ) {
        self.dateFormat = dateFormat
        self.weatherService = weatherService
        self.consumptionValue = consumptionValue
    }
    /// predict consumption.
    public func predictConsumption() throws {
        guard let currentWeather = weatherService.weather?.currentWeather else {
            return
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        let date = Date()
        let currentCalendar = Calendar.current
        let weekdays = currentCalendar.shortWeekdaySymbols
        let formattedDateString = dateFormatter.string(
            from: date
        )
        let dayOfWeek = currentCalendar.component(
            .weekday,
            from: date
        ) - 1
        
        do {
            let model = try ClimateEnergyConsumption(
                configuration: MLModelConfiguration()
            )
            let value = try model.prediction(
                date: formattedDateString,
                T_out: currentWeather.temperature.value,
                Press_mm_hg: currentWeather.pressure.value,
                RH_out: currentWeather.humidity,
                Windspeed: currentWeather.wind.speed.value,
                Visibility: currentWeather.visibility.value,
                Tdewpoint: currentWeather.dewPoint.value,
                WeekStatus: calendarIsDateInWeekend(
                    calendar: currentCalendar,
                    date: date
                ),
                Day_of_week: weekdays[dayOfWeek]
            ).Appliances
            consumptionValue = consumptionFormat(
                value: value
            )
        } catch {
            throw error
        }
    }
    /**
        Calendar is date in weekend.

        - Parameter calendar: calendar.
        - Parameter date: date.
    */
    private func calendarIsDateInWeekend(
        calendar: Calendar,
        date: Date
    ) -> String {
        calendar.isDateInWeekend(date) ? "weekend":"weekday"
    }
    /**
        Consumption format.

        - Parameter value: value.
    */
    private func consumptionFormat(
        value: Double
    ) -> String {
        String(format: "%.2f",value/1000) + " Kwh"
    }
}
