//
//  File.swift
//
//
//  Created by Claudio Cavalli on 21/12/22.
//

import ManhattanCore
import RealmSwift
import SwiftUI

struct EventDetail: View {
    @Environment(\.appEnvironmentValue) var appEnvironment: AppEnvironment
    @ObservedRealmObject var event: Event
    @Binding var isEditing: Bool
    @State private var isPickingSymbol = false
    
    var body: some View {
        List {
            taskTitle()
            taskDate()
            Text("eventDetailView_profile_title_divider".localized)
                .fontWeight(.bold)
            taskRows()
            addTaskButton()
        }
        .disabled(!isEditing)
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
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
                .foregroundColor(event.colorOption)
                .opacity(isEditing ? 0.3 : 1.0)
            }
            .buttonStyle(.plain)
            .padding(.horizontal, 5.0)

            if isEditing {
                TextField(
                    "eventDetailView_profile_title_textfield".localized,
                    text: $event.title
                )
                .font(.title2)
            } else {
                Text(event.title)
                    .font(.title2)
                    .fontWeight(.semibold)
            }
        }
    }
    
    @ViewBuilder
    func taskDate() -> some View {
        if isEditing {
            DatePicker(
                "eventDetailView_profile_title_date".localized,
                selection: $event.date
            )
            .labelsHidden()
            .listRowSeparator(.hidden)
        } else {
            HStack {
                Text(event.dateFormatted)
            }
            .listRowSeparator(.hidden)
        }
    }
    
    @ViewBuilder
    func taskRows() -> some View {
        ForEach(event.tasks) { eventTask in
                TaskRow(
                    isEditing: $isEditing,
                    task: eventTask
                )
        }
        .onDelete(
            perform: { indexSet in
                deleteElement(indexSet: indexSet)
            }
        )
    }
    
    @ViewBuilder
    func addTaskButton() -> some View {
        Button {
            writeElement()
        } label: {
            HStack {
                Image(
                    systemName: "plus"
                )
                Text("eventDetailView_profile_add_button".localized)
            }
        }
        .buttonStyle(.borderless)
    }
    
    @MainActor
    private func deleteElement(
        indexSet: IndexSet
    ) {
        guard let eventThaw = event.tasks.realm?.thaw() else {
            appEnvironment.realm?.writeAsync {
                appEnvironment.realm?.delete(event.tasks[indexSet.count - 1])
            }
            return
        }
        eventThaw.writeAsync {
            $event.tasks.remove(
                atOffsets: indexSet
            )
        }
    }
    
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
                        appEnvironment.realm?.add(eventTask)
                        event.tasks.append(eventTask)
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
                    event.thaw()?.tasks.append(eventTask)
                }
    }
}
