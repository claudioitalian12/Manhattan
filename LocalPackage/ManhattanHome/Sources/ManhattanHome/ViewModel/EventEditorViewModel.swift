//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 03/01/23.
//

import ManhattanCore
import RealmSwift
import SwiftUI

// MARK: EventEditorViewModel
public final class EventEditorViewModel: ManhattanViewModelProtocol {
    /// editing Event.
    @ObservedRealmObject var editingEvent: Event = Event()
    /// is deleted.
    @Published var isDeleted: Bool = false
    /// event.
    @ObservedRealmObject var event: Event = Event()
    /// is new.
    @Published var isNew: Bool = false
    /// is editing.
    @Published var isEditing: Bool = false
    /**
        Init.

        - Parameter editingEvent: editing event.
        - Parameter isDeleted: is deleted.
        - Parameter event: event.
        - Parameter isNew: is new.
        - Parameter isEditing: is editing.
    */
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
    /// close keyboard.
    func closeKeyboard() {
        UIApplication.shared.sendAction(
            #selector(
                UIResponder.resignFirstResponder
            ),
            to: nil,
            from: nil,
            for: nil
        )
    }
}
