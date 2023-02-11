//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 03/01/23.
//

import ManhattanCore
import RealmSwift
import SwiftUI

// MARK: EventListViewModel
public final class EventListViewModel: ManhattanViewModelProtocol {
    /// event data.
    @ObservedObject var eventData: EventData = EventData()
    /// new event.
    @ObservedRealmObject var newEvent: Event = Event()
    /// selected event.
    @Published var selectedEvent: Event? = nil
    /**
        Init.

        - Parameter eventData: event data.
        - Parameter newEvent: new event.
        - Parameter selectedEvent: selected event.
    */
    init(
        eventData: EventData = EventData(),
        newEvent: Event = Event(),
        selectedEvent: Event? = nil
    ) {
        self.eventData = eventData
        self.newEvent = newEvent
        self.selectedEvent = selectedEvent
    }
}
