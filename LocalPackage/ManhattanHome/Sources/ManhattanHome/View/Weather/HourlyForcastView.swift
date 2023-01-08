//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 18/12/22.
//

import WeatherKit
import SwiftUI

struct HourlyForcastView: View {
    @StateObject var viewModel: WeatherAppleService
    private let opacityValue = 0.5
    private let spacingValue = 20.0
    
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
