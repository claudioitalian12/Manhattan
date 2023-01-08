//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 03/01/23.
//

import ManhattanCore
import RealmSwift
import SwiftUI

public final class EventListViewModel: ManhattanViewModelProtocol {
    @ObservedObject var eventData: EventData = EventData()
    @ObservedRealmObject var newEvent: Event = Event()
    @Published var selectedEvent: Event? = nil
    
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
