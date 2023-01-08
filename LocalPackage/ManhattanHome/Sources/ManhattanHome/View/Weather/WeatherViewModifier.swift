//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 22/12/22.
//

import SwiftUI

// MARK: TextWeatherViewModifier
struct TextWeatherViewModifier: ViewModifier {
    
    func body(
        content: Content
    ) -> some View {
        content
            .font(.largeTitle)
            .multilineTextAlignment(.center)
    }
}

extension Text {
    func customTextWeatherView() -> some View {
        modifier(
            TextWeatherViewModifier()
        )
    }
}

// MARK: KwhConsumptionStackViewModifier
struct KwhConsumptionStackViewModifier: ViewModifier {
    func body(
        content: Content
    ) -> some View {
        content
            .frame(
                maxWidth: .infinity
            )
            .padding()
            .background {
                Color.blue
            }
            .clipShape(
                RoundedRectangle(
                    cornerRadius: 10.0,
                    style: .continuous
                )
            )
            .foregroundColor(.white)
    }
}

extension VStack {
    func customStackKWHCosumption() -> some View {
        modifier(
            KwhConsumptionStackViewModifier()
        )
    }
}

// MARK: KwhConsumptionTextViewModifier
struct KwhConsumptionTextViewModifier: ViewModifier {
    
    func body(
        content: Content
    ) -> some View {
        content
            .multilineTextAlignment(
                .center
            )
            .font(.subheadline)
            .opacity(0.5)
    }
}

extension Text {
    func customTextKWHCosumption() -> some View {
        modifier(
            KwhConsumptionTextViewModifier()
        )
    }
}

// MARK: HourlyForcastViewVStackViewModifier
struct HourlyForcastViewVStackViewModifier: ViewModifier {
    
    func body(
        content: Content
    ) -> some View {
        content
            .padding()
            .background {
                Color.blue
            }
            .clipShape(
                RoundedRectangle(
                    cornerRadius: 10.0,
                    style: .continuous
                )
            )
            .foregroundColor(.white)
    }
}

extension VStack {
    func customVStackHourlyForcastView() -> some View {
        modifier(
            HourlyForcastViewVStackViewModifier()
        )
    }
}

// MARK: TenDayForcastViewVStackViewModifier
struct TenDayForcastViewVStackViewModifier: ViewModifier {
    
    func body(
        content: Content
    ) -> some View {
        content
            .frame(
                maxWidth: .infinity
            )
            .padding()
            .background(
                Color.blue
            )
            .clipShape(
                RoundedRectangle(
                    cornerRadius: 10.0,
                    style: .continuous
                )
            )
            .foregroundColor(.white)
    }
}

extension VStack {
    func customVStackTenDayForecastView() -> some View {
        modifier(
            TenDayForcastViewVStackViewModifier()
        )
    }
}
