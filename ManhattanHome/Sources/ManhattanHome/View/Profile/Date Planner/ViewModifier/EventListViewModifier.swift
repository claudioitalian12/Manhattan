//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 30/12/22.
//

import ManhattanCore
import RealmSwift
import SwiftUI

struct EventSectionTitleDateViewModifier: ViewModifier {
    
    func body(
        content: Content
    ) -> some View {
        content
            .font(.callout)
            .foregroundColor(.secondary)
            .fontWeight(.bold)
    }
}

extension Text {
    func customEventSectionTitleDate() -> some View {
        modifier(
            EventSectionTitleDateViewModifier()
        )
    }
}

struct EventListRowViewModifier: ViewModifier {
    @Binding var eventData: EventData
    @Binding var selected: Event?
    @Binding var isPresented: Bool
    var event: Event

    func body(
        content: Content
    ) -> some View {
        content
            .contentShape(Rectangle())
            .sheet(
                isPresented: $isPresented
            ) {
                NavigationView {
                    EventEditor(
                        viewModel: EventEditorViewModel(
                            editingEvent: selected ?? Event(),
                            event: event,
                            isNew: false,
                            isEditing: false
                        ),
                        eventData: $eventData,
                        isPresented: $isPresented
                    )
                }
            }
            .onTapGesture {
                selected = event
                isPresented.toggle()
            }
    }
}

extension View {
    func customEventListRow(
        eventData: Binding<EventData>,
        selectedEvent: Binding<Event?>,
        isPresented: Binding<Bool>,
        event: Event
    ) -> some View {
        modifier(
            EventListRowViewModifier(
                eventData: eventData,
                selected: selectedEvent,
                isPresented: isPresented,
                event: event
            )
        )
    }
}

struct EventListVStackViewModifier: ViewModifier {
    @Binding var eventData: EventData
    @Binding var newEvent: Event
    @Binding var isPresented: Bool
    
    func body(
        content: Content
    ) -> some View {
        content
            .sheet(
                isPresented: $isPresented
            ) {
                NavigationView {
                    EventEditor(
                        viewModel: EventEditorViewModel(
                            event: newEvent,
                            isNew: true,
                            isEditing: true
                        ),
                        eventData: $eventData,
                        isPresented: $isPresented
                    )
                }
            }
    }
}

extension VStack {
    func customEventListVStack(
        eventData: Binding<EventData>,
        newEvent: Binding<Event>,
        isPresented: Binding<Bool>
    ) -> some View {
        modifier(
            EventListVStackViewModifier(
                eventData: eventData,
                newEvent: newEvent,
                isPresented: isPresented
            )
        )
    }
}
