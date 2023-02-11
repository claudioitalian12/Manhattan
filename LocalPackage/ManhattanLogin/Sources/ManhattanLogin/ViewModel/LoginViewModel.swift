//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 04/12/22.
//

import ManhattanCore
import SwiftUI
import RealmSwift

// MARK: LoginViewModel
public final class LoginViewModel: ManhattanViewModelProtocol {
    @Published var username = String()
    @Published var password = String()
    @Published var isOverlayHidden: Bool = false
    @Published var isAlertHidden: Bool = false
    @Published var errorMessage: String = ""
    private var userService: UserServiceProtocol?
    
    init(
        userService: UserServiceProtocol? = nil
    ) {
        self.userService = userService
    }
    
    @MainActor
    func loginUser(
        app: RealmSwift.App
    ) async throws {
        do {
            try await userService?.loginUser(
                app: app,
                email: username,
                password: password
            )
            return
        } catch {
            throw error
        }
    }
    
    @MainActor
    func loginOperation(
        app: AppEnvironment
    ) async {
        do {
            await changeOverlayHiddenState()
            try await loginUser(
                app: app.getDatabaseApp()
            )
            try await app.setSync()
            await changeOverlayHiddenState()
            await changeAuthState(
                app: app
            )
        }
        catch {
            errorMessage = error.localizedDescription
            await changeOverlayHiddenState()
            await changeAlertHiddenState()
        }
    }
    
    @MainActor
    private func changeOverlayHiddenState() async {
        isOverlayHidden.toggle()
    }
    
    @MainActor
    private func changeAlertHiddenState() async {
        isAlertHidden.toggle()
    }
    
    @MainActor
    private func changeAuthState(
        app: AppEnvironment
    ) async {
        app.gateway = .home
    }
}
