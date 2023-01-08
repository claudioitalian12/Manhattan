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

protocol WhConsumptionViewModelProtocol: ManhattanViewModelProtocol {
    var weatherService: WeatherAppleService { get set }
    var consumptionValue: String { get set }
    func predictConsumption() throws
}

public final class WhConsumptionViewModel: WhConsumptionViewModelProtocol {
    private let dateFormat: String
    var weatherService: WeatherAppleService
    @Published var consumptionValue: String
    
    init(
        dateFormat: String,
        weatherService: WeatherAppleService,
        consumptionValue: String = ""
    ) {
        self.dateFormat = dateFormat
        self.weatherService = weatherService
        self.consumptionValue = consumptionValue
    }

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
    
    private func calendarIsDateInWeekend(
        calendar: Calendar,
        date: Date
    ) -> String {
        calendar.isDateInWeekend(date) ? "weekend":"weekday"
    }
    
    private func consumptionFormat(
        value: Double
    ) -> String {
        String(format: "%.2f",value/1000) + " Kwh"
    }
}
