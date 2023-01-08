//
//  ManhattanAppEnvironemt.swift
//  Manhattan
//
//  Created by Claudio Cavalli on 11/12/22.
//

import SwiftUI
import RealmSwift

public final class AppEnvironment: ObservableObject, EnvironmentKey {
    public static let defaultValue = AppEnvironment()
    @Published public var realm: Realm? = nil
    @Published var app = RealmSwift.App(id: "manhattan-uyvwz")
    @Published public var gateway: GatewayType = .login
    
    public init() {
        gateway = app.currentUser != nil ? .home:.login
    }
    
    public func getDatabaseApp() -> RealmSwift.App {
        app
    }
    
    public func getDatabaseUser() -> User? {
        app.currentUser
    }
    
    public func getUserID() -> String? {
        app.currentUser?.id
    }
    
    public func getUserEmail() -> String? {
        app.currentUser?.profile.email
    }
    
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

public extension EnvironmentValues {
    var appEnvironmentValue: AppEnvironment {
        get { self[AppEnvironment.self] }
        set { self[AppEnvironment.self] = newValue }
    }
}
