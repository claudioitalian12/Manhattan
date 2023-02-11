//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 18/12/22.
//

import WeatherKit
import SwiftUI

// MARK: HourlyForcastView
struct HourlyForcastView: View {
    /// view model.
    @StateObject var viewModel: WeatherAppleService
    /// opacity value.
    private let opacityValue = 0.5
    /// spacing value.
    private let spacingValue = 20.0
    /// body.
    var body: some View {
        VStack(
            alignment: .leading
        ) {
            Text("homeView_hours_title".localized)
                .font(.caption)
                .opacity(opacityValue)
            hourlySection()
        }
        .customVStackHourlyForcastView()
    }
    /// hourly section.
    @ViewBuilder
    private func hourlySection() -> some View {
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach(
                    viewModel.hourWeather ?? [],
                    id: \.date
                ) { hourWeatherItem in
                    VStack(
                        spacing: spacingValue
                    ) {
                        Text(hourWeatherItem.date.formatAsAbbreviatedTime())
                        Image(
                            systemName: "\(hourWeatherItem.symbolName).fill"
                        )
                        .foregroundColor(.yellow)
                        Text(hourWeatherItem.temperature.formatted())
                            .fontWeight(.medium)
                    }
                    .padding()
                }
            }
        }
    }
}
