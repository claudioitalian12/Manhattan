//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 03/01/23.
//

import ManhattanCore
import RealmSwift
import SwiftUI

public final class EventEditorViewModel: ManhattanViewModelProtocol {
    @ObservedRealmObject var editingEvent: Event = Event()
    @Published var isDeleted: Bool = false
    @ObservedRealmObject var event: Event = Event()
    @Published var isNew: Bool = false
    @Published var isEditing: Bool = false
    
    init(
        editingEvent: Event = Event(),
        isDeleted: Bool = false,
        event: Event = Event(),
        isNew: Bool = false,
        isEditing: Bool = false
    ) {
        self.editingEvent = editingEvent
        self.isDeleted = isDeleted
        self.event = event
        self.isNew = isNew
        self.isEditing = isEditing
    }
}
