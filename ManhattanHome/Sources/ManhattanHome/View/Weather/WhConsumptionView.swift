//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 20/12/22.
//

import WeatherKit
import SwiftUI

struct KwhConsumptionView<T: WhConsumptionViewModelProtocol>: View {
    @StateObject var viewModel: T
    @State var errorMessage: String = ""
    
    var body: some View {
        VStack(
            spacing: 20.0
        ) {
            Text("kwhConsumptionView_kwh_text".localized)
                .customTextKWHCosumption()
            Text(viewModel.consumptionValue)
        }
        .customStackKWHCosumption()
        .task(
            id: viewModel.weatherService.weather
        ) {
            if viewModel.consumptionValue.isEmpty {
                do {
                    try viewModel.predictConsumption()
                } catch {
                    errorMessage = error.localizedDescription
                }
            }
        }
    }
}
