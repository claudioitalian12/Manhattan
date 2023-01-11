//
//  File.swift
//
//
//  Created by Claudio Cavalli on 21/12/22.
//

import ManhattanCore
import RealmSwift
import SwiftUI

struct TaskRow: View {
    @Environment(\.appEnvironmentValue) var appEnvironment: AppEnvironment
    @Binding var isEditing: Bool
    @ObservedRealmObject var task: EventTask
    @FocusState private var isFocused: Bool

    var body: some View {
        HStack {
            Button {
                if isEditing {
                    appEnvironment.realm?.writeAsync({
                        guard let thaw = task.thaw() else {
                            task.isCompleted.toggle()
                            return
                        }
                        thaw.isCompleted.toggle()
                    })
                }
            } label: {
                Image(
                    systemName: task.isCompleted ? "checkmark.circle.fill" : "circle"
                )
            }
            .buttonStyle(.plain)

            if isEditing || task.isNew {
                TextField(
                    "eventTaskRow_profile_field_text".localized,
                    text: $task.text,
                    axis: .vertical
                )
                .focused($isFocused)
                .onChange(of: isFocused) { newValue in
                    if newValue == false {
                        appEnvironment.realm?.writeAsync({
                            guard let thaw = task.thaw() else {
                                task.isNew = false
                                return
                            }
                            thaw.isNew = false
                        })
                    }
                }
            } else {
                Text(task.text)
            }

            Spacer()
        }
        .padding(.vertical, 10.0)
        .task {
            if task.isNew {
                isFocused = true
            }
        }
    }
}
