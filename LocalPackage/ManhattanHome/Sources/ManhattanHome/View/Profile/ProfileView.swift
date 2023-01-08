//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 19/12/22.
//

import ManhattanCore
import SwiftUI

struct ProfileView: View {
    @Environment(\.appEnvironmentValue) var appEnvironment: AppEnvironment
    @StateObject var viewModel: ProfileViewModel = ProfileViewModel()
    @Binding var homeShowOverlay: Bool
    private let stackSpacing = 20.0

    var body: some View {
        ScrollView {
            VStack(
                spacing: stackSpacing
            ) {
                VStack(
                    spacing: stackSpacing
                ) {
                    buildProfileInfo()
                    Divider()
                    VStack(
                        spacing: stackSpacing
                    ) {
                        buildDatePicker()
                        Divider()
                        EventList(
                            date: $viewModel.date
                        )
                        Spacer(
                            minLength: stackSpacing
                        )
                    }
                }
                .customProfileContentVStack()
            }
        }.customProfileScrollView(
            isLoading: $viewModel.isLoading,
            isAlertHidden: $viewModel.isAlertHidden,
            errorMessage: $viewModel.errorMessage
        )
        .refreshable {
            Task {
                viewModel.placeholderProfile.toggle()
                try await viewModel.setSync(
                    app: appEnvironment
                )
                viewModel.placeholderProfile.toggle()
            }
        }
        .task(
            id: appEnvironment.realm
        ) {
            viewModel.placeholderProfile.toggle()
        }
    }
    
    @ViewBuilder
    private func buildProfileInfo() -> some View {
        Image(
            "manhattan",
            bundle: .module
        )
        .customImageProfileViewModifier()
        Text(appEnvironment.getDatabaseUser()?.profile.email ?? "")
            .multilineTextAlignment(.center)
        buildMenuSettings()
    }
    
    @ViewBuilder
    private func buildMenuSettings() -> some View {
        Menu {
            Button{
                UIPasteboard.general.string = appEnvironment.getUserID()
            } label: {
                buildMenuLabel(
                    text: "profileView_profile_menu_id".localized,
                    systemName: "doc.on.doc"
                )
            }
            Button {
                viewModel.changeOverlayHiddenState(
                    homeShowOverlay: $homeShowOverlay
                )
                Task {
                    await viewModel.didTapLogout(
                        appEnvironment: appEnvironment
                    )
                }
            } label: {
                buildMenuLabel(
                    text: "profileView_profile_menu_logout".localized,
                    systemName: "figure.walk.departure"
                )
            }
            Button {
                viewModel.changeOverlayHiddenState(
                    homeShowOverlay: $homeShowOverlay
                )
                Task {
                    await viewModel.didtapDelete(
                        appEnvironment: appEnvironment
                    )
                }
            } label: {
                buildMenuLabel(
                    text: "profileView_profile_menu_delete".localized,
                    systemName: "trash"
                )
            }
        } label: {
            Text("\("profileView_profile_menu_setting".localized) \(Image(systemName: "person.crop.circle"))")
                .customProfileMenuTextButton()
        }
    }

    @ViewBuilder
    private func buildDatePicker() -> some View {
        DatePicker(
            "eventListView_profile_title_text".localized,
            selection: $viewModel.date
        )
        .customProfileMDatePicker()
    }
    
    @ViewBuilder
    private func buildMenuLabel(
        text: String,
        systemName: String
    ) -> some View {
        Text(text)
        Image(
            systemName: systemName
        )
    }
}
