//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 15/12/22.
//

import RealmSwift
import SwiftUI
import OSLog

public protocol UserService: AnyObject {
    func createUser(
        app: RealmSwift.App,
        email: String,
        password: String
    ) async throws
    
    func loginUser(
        app: RealmSwift.App,
        email: String,
        password: String
    ) async throws
    
    func delete(
        app: RealmSwift.App
    ) async throws
    
    func logout(
        app: RealmSwift.App
    ) async throws
    
    func subscriptionFlexbleSync(
        app: RealmSwift.App
    ) async throws -> Realm?
}

public final actor RealmUserService: UserService {
    public init() {}
    
    public func createUser(
        app: RealmSwift.App,
        email: String,
        password: String
    ) async throws {
        let client = app.emailPasswordAuth
        do {
            try await client.registerUser(
                email: email,
                password: password
            )
            os_log(
                .debug,
                "Successfully registered user."
            )
        } catch {
            os_log(
                .debug,
                "Failed to register: \(error.localizedDescription)"
            )
            throw error
        }
    }
    
    public func loginUser(
        app: RealmSwift.App,
        email: String,
        password: String
    ) async throws {
        do {
            _ = try await withCheckedThrowingContinuation { continuation in
                app.login(
                    credentials: Credentials.emailPassword(
                        email: email,
                        password: password
                    )
                ) { (result) in
                    continuation.resume(
                        with: result
                    )
                }
            }
            os_log(
                .debug,
                "Successfully login user."
            )
            return
        } catch {
            os_log(
                .debug,
                "Failed to login: \(error.localizedDescription)"
            )
            throw error
        }
    }
    
    public func delete(
        app: RealmSwift.App
    ) async throws {
        do {
            try await app.currentUser?.delete()
        } catch {
            os_log(
                .debug,
                "Failed to delete: \(error.localizedDescription)"
            )
            throw error
        }
    }
    
    public func logout(
        app: RealmSwift.App
    ) async throws {
        do {
            try await app.currentUser?.logOut()
        } catch {
            os_log(
                .debug,
                "Failed to logout: \(error.localizedDescription)"
            )
            throw error
        }
    }
    
    public func subscriptionFlexbleSync(
        app: RealmSwift.App
    ) async throws -> Realm? {
        do {
            var config = app.currentUser?.flexibleSyncConfiguration(
                initialSubscriptions: { subs in
                    let querySubscription = QuerySubscription<Event>.init { event in
                        event.owner_id == app.currentUser?.id
                    }
                    let queryTaskSubscription = QuerySubscription<EventTask>.init { event in
                        event.owner_id == app.currentUser?.id
                    }
                    
                    let queryBoardsDataSubscription = QuerySubscription<BoardsData>.init { event in
                        event.owner_id == app.currentUser?.id
                    }
                    let queryBoardSubscription = QuerySubscription<Board>.init { event in
                        event.shared_id.contains(app.currentUser?.id ?? "")
                    }
                    let queryBoardTaskSubscription = QuerySubscription<BoardTask>.init { event in
                        event.shared_id.contains(app.currentUser?.id ?? "")
                    }
                    
                    subs.append(querySubscription)
                    subs.append(queryTaskSubscription)
                    subs.append(queryBoardsDataSubscription)
                    subs.append(queryBoardSubscription)
                    subs.append(queryBoardTaskSubscription)
                })
            
            config?.objectTypes = [
                Event.self,
                EventTask.self,
                BoardsData.self,
                Board.self,
                BoardTask.self
            ]
            
            let realm = try await Realm(
                configuration: config ?? .defaultConfiguration,
                downloadBeforeOpen: .always
            )
            return realm
        } catch {
            os_log(
                .debug,
                "Failed to sync: \(error.localizedDescription)"
            )
            throw error
        }
    }
}
