//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 29/12/22.
//

import ManhattanCore
import RealmSwift
import SwiftUI

public final class ProfileViewModel: ManhattanViewModelProtocol {
    @Published var date = Date.now
    @Published var isLoading = true
    @Published var errorMessage: String = ""
    @Published var isAlertHidden = false
    @Published var placeholderProfile: Bool = true
    
    init(
        _ date: Date = Date.now,
        _ isLoading: Bool = true,
        _ errorMessage: String = "",
        _ isAlertHidden: Bool = false,
        _ placeholderProfile: Bool = true
    ) {
        self.date = date
        self.isLoading = isLoading
        self.errorMessage = errorMessage
        self.isAlertHidden = isAlertHidden
        self.placeholderProfile = placeholderProfile
    }
    
    @MainActor
    func didTapLogout(
        appEnvironment: AppEnvironment
    ) async {
        do {
            try await RealmUserService().logout(
                app: appEnvironment.getDatabaseApp()
            )
            appEnvironment.gateway = .login
        } catch {
            errorMessage = error.localizedDescription
            isAlertHidden = !isAlertHidden
        }
    }
    
    @MainActor
    func didtapDelete(
        appEnvironment: AppEnvironment
    ) async {
        do {
            try await RealmUserService().delete(
                app: appEnvironment.getDatabaseApp()
            )
            appEnvironment.gateway = .login
        } catch {
            errorMessage = error.localizedDescription
            isAlertHidden = !isAlertHidden
        }
    }
    
    func changeOverlayHiddenState(
        homeShowOverlay: Binding<Bool>
    ) {
        homeShowOverlay.wrappedValue = !homeShowOverlay.wrappedValue
    }
    
    @MainActor
    func setSync(
        app: AppEnvironment
    ) async throws {
        do {
            try await app.setSync()
        } catch {
            throw error
        }
    }
    
    func getListViewModel() -> EventListViewModel {
        HomeFactory().getListViewModel()
    }
}
