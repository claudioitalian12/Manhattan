//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 28/12/22.
//

import ManhattanCore
import SwiftUI

// MARK: ProfileScrollViewModifier
struct ProfileScrollViewModifier: ViewModifier {
    @Environment(\.appEnvironmentValue) var appEnvironment: AppEnvironment
    @Binding var isLoading: Bool
    @Binding var isAlertHidden: Bool
    @Binding var errorMessage: String
    
    func body(
        content: Content
    ) -> some View {
        content
            .scrollIndicators(.hidden)
            .frame(
                maxWidth: .infinity
            )
            .redacted(
                reason: isLoading ? .placeholder:[]
            )
            .alert(
                "homeView_profile_alert_title".localized,
                isPresented: $isAlertHidden,
                actions: {
                    Button(
                        "homeView_profile_alert_button".localized,
                        role: .cancel
                    ) { }
                },
                message: {
                    Text(errorMessage)
                }
            )
            .task(
                id: appEnvironment.getDatabaseUser()
            ) {
                if appEnvironment.getDatabaseUser() != nil {
                    isLoading = false
                }
            }
    }
}

extension ScrollView {
    func customProfileScrollView(
        isLoading: Binding<Bool>,
        isAlertHidden: Binding<Bool>,
        errorMessage: Binding<String>
    ) -> some View {
        modifier(
            ProfileScrollViewModifier(
                isLoading: isLoading,
                isAlertHidden: isAlertHidden,
                errorMessage: errorMessage
            )
        )
    }
}

extension Image {
    func customImageProfileViewModifier() -> some View {
        self
            .resizable()
            .aspectRatio(
                contentMode: .fit
            )
            .frame(
                maxWidth: 100.0,
                maxHeight: 100.0
            )
    }
}

struct ProfileMenuTextButtonModifier: ViewModifier {
    
    func body(
        content: Content
    ) -> some View {
        content
            .foregroundColor(.white)
            .frame(maxWidth: 160.0)
            .padding(10.0)
            .background(.blue)
            .clipShape(
                RoundedRectangle(
                    cornerRadius: 10.0
                )
            )
    }
}

extension Text {
    func customProfileMenuTextButton() -> some View {
        modifier(
            ProfileMenuTextButtonModifier()
        )
    }
}

struct ProfileDatePickerModifier: ViewModifier {
    
    func body(
        content: Content
    ) -> some View {
        content
            .datePickerStyle(
                .graphical
            )
    }
}

extension DatePicker {
    func customProfileMDatePicker() -> some View {
        modifier(
            ProfileDatePickerModifier()
        )
    }
}

struct ProfileContentVStackModifier: ViewModifier {
    
    func body(
        content: Content
    ) -> some View {
        content
            .padding()
    }
}

extension VStack {
    func customProfileContentVStack() -> some View {
        modifier(
            ProfileContentVStackModifier()
        )
    }
}
