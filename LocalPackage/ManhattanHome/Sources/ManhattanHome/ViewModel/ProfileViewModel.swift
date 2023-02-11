//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 29/12/22.
//

import ManhattanCore
import RealmSwift
import SwiftUI

// MARK: ProfileViewModel
public final class ProfileViewModel: ManhattanViewModelProtocol {
    /// date.
    @Published var date = Date.now
    /// is loading.
    @Published var isLoading = true
    /// error message.
    @Published var errorMessage: String = ""
    /// is alert hidden.
    @Published var isAlertHidden = false
    /// placeholder profile.
    @Published var placeholderProfile: Bool = true
    /**
        Init.

        - Parameter date: date.
        - Parameter isLoading: is loading.
        - Parameter errorMessage: error message.
        - Parameter isAlertHidden: is alert hidden.
        - Parameter placeholderProfile: placeholder profile.
    */
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
    /**
        Did tap logout.

        - Parameter appEnvironment: app environment.
    */
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
    /**
        Did tap delete.

        - Parameter appEnvironment: app environment.
    */
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
    /**
        Change overlay hidden state.

        - Parameter homeShowOverlay: home show overlay..
    */
    func changeOverlayHiddenState(
        homeShowOverlay: Binding<Bool>
    ) {
        homeShowOverlay.wrappedValue = !homeShowOverlay.wrappedValue
    }
    /**
        Set sync.

        - Parameter app: app environment..
    */
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
    /// get list view model.
    func getListViewModel() -> EventListViewModel {
        HomeFactory().getListViewModel()
    }
}
