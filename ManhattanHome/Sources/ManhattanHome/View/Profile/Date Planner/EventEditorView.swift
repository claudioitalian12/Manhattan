//
//  File.swift
//
//
//  Created by Claudio Cavalli on 21/12/22.
//

import ManhattanCore
import RealmSwift
import SwiftUI

struct EventEditor: View {
    @Environment(\.appEnvironmentValue) private var appEnvironment: AppEnvironment
    @ObservedObject var viewModel: EventEditorViewModel
    @Binding var eventData: EventData
    @Binding var isPresented: Bool
    
    private var isEventDeleted: Bool {
        !eventData.exists(viewModel.event) && !viewModel.isNew && viewModel.isDeleted
    }

    var body: some View {
        contentStack()
        .task {
            if !viewModel.isNew {
                viewModel.editingEvent = viewModel.event
            }
        }
        .task(
            id: viewModel.isEditing
        ) {
            if !viewModel.isEditing {
                hideKeyboard()
            }
        }
        .overlay(
            alignment: .center
        ) {
            if isEventDeleted {
                Color(UIColor.systemBackground)
                Text("eventEditorView_profile_title_detail_text".localized)
                    .foregroundStyle(.secondary)
            }
        }
    }
    
    @ViewBuilder
    func contentStack() -> some View {
        VStack {
            EventDetail(
                event: viewModel.isNew ? viewModel.event:viewModel.editingEvent,
                isEditing: $viewModel.isEditing
            )
            .toolbar {
                ToolbarItem(
                    placement: .cancellationAction
                ) {
                    cancelButton()
                }
                ToolbarItem {
                    rightButton()
                }
            }
            .disabled(isEventDeleted)
            
            if viewModel.isEditing && !viewModel.isNew {
                deleteButton()
            }
        }
    }
    
    @ViewBuilder
    func cancelButton() -> some View {
        Button("eventEditorView_profile_navigation_remove_button".localized) {
            isPresented.toggle()
        }
    }
    
    @ViewBuilder
    func rightButton() -> some View {
        Button {
            if viewModel.isNew {
                do {
                    try eventData.add(
                        realm: appEnvironment.realm,
                        event: viewModel.event
                    )
                    isPresented.toggle()
                } catch {
                    isPresented.toggle()
                }
            } else {
                if viewModel.isEditing && !viewModel.isDeleted {
                    withAnimation {
                        do {
                            try eventData.add(
                                realm: appEnvironment.realm,
                                event: viewModel.editingEvent
                            )
                        } catch {
                            isPresented.toggle()
                        }
                    }
                }
            }
            viewModel.isEditing.toggle()
        } label: {
            Text(viewModel.isNew ? "eventEditorView_profile_navigation_add_button".localized : (viewModel.isEditing ? "eventEditorView_profile_navigation_done_button".localized : "eventEditorView_profile_navigation_edit_button".localized))
        }
    }
    
    @ViewBuilder
    func deleteButton() -> some View {
        Button(
            role: .destructive,
            action: {
                viewModel.isDeleted = true
                do {
                    try eventData.delete(
                        realm: appEnvironment.realm,
                        event: viewModel.editingEvent
                    )
                } catch {
                    isPresented.toggle()
                }
            }, label: {
                Label("eventEditorView_profile_toolbar_delete_button".localized, systemImage: "trash.circle.fill")
                    .font(.title2)
                    .foregroundColor(.red)
            }
        )
        .padding()
    }
}
