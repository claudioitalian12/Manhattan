//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 09/12/22.
//

import ManhattanCore
import SwiftUI
import RealmSwift

// MARK: SignUpViewModel
public final class SignUpViewModel: ManhattanViewModelProtocol {
    /// username.
    @Published var username = String()
    /// password.
    @Published var password = String()
    /// isOverlayHIdden.
    @Published var isOverlayHidden: Bool = false
    /// isAlertHidden.
    @Published var isAlertHidden: Bool = false
    /// error message.
    @Published var errorMessage: String = ""
    /// userService.
    private var userService: UserServiceProtocol?
    /**
        Init.

        - Parameter userService: user service.
    */
    init(
        userService: UserServiceProtocol? = nil
    ) {
        self.userService = userService
    }
    /**
        Create user.

        - Parameter app: app.
    */
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
    /**
        Login user.

        - Parameter app: app.
    */
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
    /**
        Signup operation.

        - Parameter app: app.
    */
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
    /// change overlay hidden state.
    @MainActor
    func changeOverlayHiddenState() async {
        isOverlayHidden.toggle()
    }
    /// change alert hidden state.
    @MainActor
    func changeAlertHiddenState() async {
        isAlertHidden.toggle()
    }
    /**
        Change Auth state.

        - Parameter app: app.
    */
    @MainActor
    func changeAuthState(
        app: AppEnvironment
    ) async {
        app.gateway = .home
    }
}
