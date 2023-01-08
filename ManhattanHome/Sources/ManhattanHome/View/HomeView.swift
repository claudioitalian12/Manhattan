//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 15/12/22.
//

import ManhattanCore
import CoreLocation
import RealmSwift
import WeatherKit
import SwiftUI

struct HomeView: View {
    @Environment(\.appEnvironmentValue) var appEnvironment: AppEnvironment
    @ObservedObject var viewModel: HomeViewModel
    @State var isLoading: Bool = true
    
    var body: some View {
        NavigationStack {
            TabView {
                switch UIDevice.current.userInterfaceIdiom {
                case .phone:
                    homeIphone()
                default:
                    homeIpad()
                }
            }
            .customTabViewHome()
        }
        .customNavigationStack(
            isOverlayHidden: $viewModel.homeShowOverlay
        )
        .redacted(
            reason: isLoading ? .placeholder:[]
        )
        .task {
            Task {
                try await viewModel.setSync(
                    app: appEnvironment
                )
                isLoading.toggle()
            }
        }
    }
    
    @ViewBuilder
    private func homeIpad() -> some View {
        HStack {
            WeatherView()
            ProfileView(
                homeShowOverlay: $viewModel.homeShowOverlay
            )
            TaskBoardView(
                viewModel: viewModel.getTaskBoardViewModel()
            )
        }
        .customHStackHome()
    }
    
    @ViewBuilder
    private func homeIphone() -> some View {
        WeatherView()
        ProfileView(
            homeShowOverlay: $viewModel.homeShowOverlay
        )
        TaskBoardView(
            viewModel: viewModel.getTaskBoardViewModel()
        )
    }
}
