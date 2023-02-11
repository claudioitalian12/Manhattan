//
//  ManhattanAppEnvironemt.swift
//  Manhattan
//
//  Created by Claudio Cavalli on 11/12/22.
//

import SwiftUI
import RealmSwift

// MARK: AppEnvironment
public final class AppEnvironment: ObservableObject, EnvironmentKey {
    /// default app environment
    public static let defaultValue = AppEnvironment()
    /// realm object
    @Published public var realm: Realm? = nil
    /// realm app object
    @Published var app = RealmSwift.App(
        id: "manhattan-uyvwz"
    )
    /// gateway type
    @Published public var gateway: GatewayType = .login
    /// init
    public init() {
        gateway = app.currentUser != nil ? .home:.login
    }
    /// get database app
    public func getDatabaseApp() -> RealmSwift.App {
        app
    }
    /// get database user
    public func getDatabaseUser() -> User? {
        app.currentUser
    }
    /// get user id
    public func getUserID() -> String? {
        app.currentUser?.id
    }
    /// get user email
    public func getUserEmail() -> String? {
        app.currentUser?.profile.email
    }
    /// subscribe for sync
    @MainActor
    public func setSync() async throws {
        guard let _ = realm else {
            do {
                let realm = try await RealmUserService().subscriptionFlexbleSync(
                    app: app
                )
                self.realm = realm
            } catch {
                throw error
            }
            return
        }
    }
}
// MARK: EnvironmentValues app environment
public extension EnvironmentValues {
    var appEnvironmentValue: AppEnvironment {
        get { self[AppEnvironment.self] }
        set { self[AppEnvironment.self] = newValue }
    }
}
