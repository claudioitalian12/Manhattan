//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 09/12/22.
//

import ManhattanCore
import SwiftUI
import RealmSwift

public final class SignUpViewModel: ManhattanViewModelProtocol {
    @Published var username = String()
    @Published var password = String()
    @Published var isOverlayHidden: Bool = false
    @Published var isAlertHidden: Bool = false
    @Published var errorMessage: String = ""

    private var userService: UserService?
    
    init(
        userService: UserService? = nil
    ) {
        self.userService = userService
    }
    
    @MainActor
    func createUser(
        app: RealmSwift.App
    ) async throws {
        do {
            try await userService?.createUser(
                app: app,
                email: username,
                password: password
            )
        } catch {
            throw error
        }
    }
    
    @MainActor
    func loginUser(
        app: RealmSwift.App
    ) async throws {
        do {
            _ = try await userService?.loginUser(
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
    func signUpOperation(
        app: AppEnvironment
    ) async {
        do {
            await changeOverlayHiddenState()
            try await createUser(
                app: app.getDatabaseApp()
            )
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
    func changeOverlayHiddenState() async {
        isOverlayHidden.toggle()
    }
    
    @MainActor
    func changeAlertHiddenState() async {
        isAlertHidden.toggle()
    }
    
    @MainActor
    func changeAuthState(
        app: AppEnvironment
    ) async {
        app.gateway = .home
    }
}
