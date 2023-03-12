//
//  File.swift
//
//
//  Created by Claudio Cavalli on 21/12/22.
//

import ManhattanCore
import RealmSwift
import SwiftUI
import OSLog

// MARK: EventData
final class EventData: ObservableObject {
    /// events
    @Published var events: RealmSwift.List<Event> = RealmSwift.List<Event>()
    /**
        Init.

        - Parameter events: list.
    */
    init(
        events: RealmSwift.List<ManhattanCore.Event> = RealmSwift.List<Event>()
    ) {
        self.events = events
    }
    /**
        Set Events List.

        - Parameter realm: realm.
    */
    @MainActor
    func setEventsList(
        realm: Realm?
    ) {
        if let eventResult = realm?.objects(Event.self) {
            self.events.removeAll()
            self.events.append(
                objectsIn: eventResult
            )
        }
    }
    /**
        Delete Event.

        - Parameter realm: realm.
        - Parameter event: event.
    */
    @MainActor
    func delete(
        realm: Realm?,
        event: Event
    ) throws {
        guard let eventThaw = event.thaw() else {
            return
        }
        
        eventThaw.realm?.writeAsync(
            {
                eventThaw.realm?.delete(
                    eventThaw
                )
            }
        ) { [weak self] error in
            if let error {
                os_log(
                    .debug,
                    "\(error.localizedDescription)"
                )
                return
            }
            guard let self else { return }
            self.setEventsList(
                realm: realm
            )
            os_log(
                .debug,
                "Delete, deleting object."
            )
        }
    }
    /**
        Add Event.

        - Parameter realm: realm.
        - Parameter event: event.
    */
    @MainActor
    func add(
        realm: Realm?,
        event: Event
    ) throws {
        if events.contains(
            where: {
                $0._id == event._id
            }
        ) {
            guard let eventThaw = event.thaw() else { return }
            do {
                try event.thaw()?.realm?.write(
                    {
                        event.thaw()?.realm?.add(
                            eventThaw,
                            update: .modified
                        )
                    }
                )
                os_log(
                    .debug,
                    "Done, saving any changes to \(event.title)."
                )
            } catch {
                os_log(
                    .debug,
                    "\(error.localizedDescription)"
                )
                throw error
            }
        } else {
            do {
                try realm?.write(
                    {
                        realm?.add(
                            event
                        )
                    }
                )
                os_log(
                    .debug,
                    "Done, saving any changes to \(event.title)."
                )
            } catch {
                os_log(
                    .debug,
                    "\(error.localizedDescription)"
                )
                throw error
            }
        }
    }
    /**
        Exists.

        - Parameter event: event.
    */
    @MainActor
    func exists(
        _ event: Event
    ) -> Bool {
        events.contains(event)
    }
    /**
        Sorted Events.

        - Parameter period: period.
    */
    @MainActor
    func sortedEvents(
        period: Period
    ) -> RealmSwift.List<Event> {
        let eventsSorted = events.filter {
            switch period {
            case .nextSevenDays:
                return $0.isWithinSevenDays
            case .nextThirtyDays:
                return $0.isWithinSevenToThirtyDays
            case .future:
                return $0.isDistant
            case .past:
                return $0.isPast
            }
        }
        .sorted {
            $0.date < $1.date
        }
        
        let list = RealmSwift.List<Event>()
        list.append(
            objectsIn: eventsSorted
        )
        
        return list
    }
}
