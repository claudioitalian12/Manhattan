//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 18/12/22.
//

import ManhattanCore
import WeatherKit
import SwiftUI

struct TenDayForcastView: View {
    @StateObject var viewModel: WeatherAppleService
    private let opacityValue: CGFloat = 0.5
    private let edgePadding: CGFloat = 0.5
    
    var body: some View {
        VStack(
            alignment: .leading
        ) {
            Text("homeView_day_title".localized)
                .font(.caption)
                .opacity(opacityValue)
            
            ForEach(
                viewModel.dayWeather ?? [],
                id: \.date
            ) { dailyWeather in
                sectionElement(
                    dailyWeather: dailyWeather
                )
            }
            .listStyle(.plain)
            .padding(edgePadding)
        }
        .customVStackTenDayForecastView()
    }
    
    @ViewBuilder
    private func sectionElement(
        dailyWeather: DayWeather
    ) -> some View {
        HStack {
            Divider()
                .hidden()
            Text(dailyWeather.date.formatAsAbbreviatedDay())
                .frame(
                    maxWidth: 50.0,
                    alignment: .leading
                )
            Divider()
                .hidden()
            Image(
                systemName: "\(dailyWeather.symbolName)"
            )
            .foregroundColor(.yellow)
            Divider()
                .hidden()
            Text(dailyWeather.lowTemperature.formatted()
            )
            .frame(maxWidth: .infinity)
            Divider()
                .hidden()
            Text(dailyWeather.highTemperature.formatted())
                .frame(
                    maxWidth: .infinity,
                    alignment: .trailing
                )
        }
        .listRowBackground(Color.blue)
        Divider()
    }
}
