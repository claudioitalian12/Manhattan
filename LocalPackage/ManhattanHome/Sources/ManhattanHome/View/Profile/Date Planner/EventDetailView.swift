//
//  File.swift
//
//
//  Created by Claudio Cavalli on 21/12/22.
//

import ManhattanCore
import RealmSwift
import SwiftUI

// MARK: EventDetail
struct EventDetail: View {
    /// app environment.
    @Environment(\.appEnvironmentValue) var appEnvironment: AppEnvironment
    /// event.
    @ObservedRealmObject var event: Event
    /// is editing.
    @Binding var isEditing: Bool
    /// is picking symbol.
    @State private var isPickingSymbol = false
    /// body.
    var body: some View {
        List {
            taskTitle()
            taskDate()
            Text(
                "eventDetailView_profile_title_divider".localized
            )
            .fontWeight(.bold)
            taskRows()
            addTaskButton()
        }
        .disabled(
            !isEditing
        )
        #if os(iOS)
        .navigationBarTitleDisplayMode(
            .inline
        )
        #endif
        .sheet(
            isPresented: $isPickingSymbol
        ) {
            SymbolPicker(
                viewModel: SymbolPickerViewModel(
                    event: event,
                    selectedColor: event.colorOption
                )
            )
        }
    }
    /// task title.
    @ViewBuilder
    func taskTitle() -> some View {
        HStack {
            Button {
                if isEditing {
                    isPickingSymbol.toggle()
                }
            } label: {
                Image(
                    systemName: event.symbol
                )
                .sfSymbolStyling()
                .foregroundColor(
                    event.colorOption
                )
                .opacity(
                    isEditing ? 0.3 : 1.0
                )
            }
            .buttonStyle(
                .plain
            )
            .padding(
                .horizontal,
                5.0
            )

            if isEditing {
                TextField(
                    "eventDetailView_profile_title_textfield".localized,
                    text: $event.title,
                    axis: .vertical
                )
                .font(
                    .title2
                )
            } else {
                Text(
                    event.title
                )
                .font(
                    .title2
                )
                .fontWeight(
                    .semibold
                )
            }
        }
    }
    /// task date.
    @ViewBuilder
    func taskDate() -> some View {
        if isEditing {
            DatePicker(
                "eventDetailView_profile_title_date".localized,
                selection: $event.date
            )
            .labelsHidden()
            .listRowSeparator(
                .hidden
            )
        } else {
            HStack {
                Text(
                    event.dateFormatted
                )
            }
            .listRowSeparator(
                .hidden
            )
        }
    }
    /// task rows.
    @ViewBuilder
    func taskRows() -> some View {
        ForEach(
            event.tasks
        ) { eventTask in
                TaskRow(
                    isEditing: $isEditing,
                    task: eventTask
                )
        }
        .onDelete(
            perform: { indexSet in
                deleteElement(
                    indexSet: indexSet
                )
            }
        )
    }
    /// add task button.
    @ViewBuilder
    func addTaskButton() -> some View {
        Button {
            Task {
                writeElement()
            }
        } label: {
            HStack {
                Image(
                    systemName: "plus"
                )
                Text(
                    "eventDetailView_profile_add_button".localized
                )
            }
        }
        .buttonStyle(
            .borderless
        )
    }
    /**
        Delete Element.

        - Parameter indexSet: index set.
    */
    @MainActor
    private func deleteElement(
        indexSet: IndexSet
    ) {
        guard let eventThaw = event.tasks.realm?.thaw() else {
            appEnvironment.realm?.writeAsync {
                appEnvironment.realm?.delete(
                    event.tasks[indexSet.count - 1]
                )
            }
            return
        }
        eventThaw.writeAsync {
            $event.tasks.remove(
                atOffsets: indexSet
            )
        }
    }
    /// write element.
    @MainActor
    private func writeElement() {
        guard let thaw = event.tasks.realm?.thaw() else {
            appEnvironment.realm?.writeAsync {
                let eventTask = EventTask(
                    event_id: event._id,
                    isNew: true,
                    owner_id: appEnvironment.getUserID(),
                    text: ""
                )
                appEnvironment.realm?.add(
                    eventTask
                )
                event.tasks.append(
                    eventTask
                )
            }
            return
        }
        thaw.writeAsync {
            let eventTask = EventTask(
                event_id: event._id,
                isNew: true,
                owner_id: appEnvironment.getUserID(),
                text: ""
            )
            $event.tasks.append(
                eventTask
            )
        }
    }
}
