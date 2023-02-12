//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 11/02/23.
//

import ManhattanCore
import RealmSwift
import SwiftUI

// MARK: TaskBoardCardView
struct TaskBoardDetailView: View {
    /// app environment.
    @Environment(\.appEnvironmentValue) var appEnvironment: AppEnvironment
    /// task.
    @ObservedRealmObject var task: BoardTask
    /// end edit.
    @Binding var endEdit: Bool
    /// selected state.
    @State var selectedState: TaskSection
    /// selected index.
    @State var selectedIndex: Int = 0
    /// body.
    var body: some View {
        NavigationStack {
            List {
                sectionTaskState()
                sectionBody()
                sectionAttachments()
                sectionTask()
                sectionComments()
            }
            .scrollIndicators(
                .hidden
            )
            .listStyle(
                .insetGrouped
            )
            .toolbar {
                Button {
                    endEdit.toggle()
                } label: {
                    Text(
                        "taskView_board_task_done".localized
                    )
                }
            }
        }
    }
    /// section task state.
    @ViewBuilder
    private func sectionTaskState() -> AnyView {
        AnyView(
            Section {
            } header: {
                VStack {
                    TextField(
                        task.title,
                        text: $task.title,
                        axis: .vertical
                    )
                    .font(
                        .title
                    )
                    .multilineTextAlignment(
                        .center
                    )
                    Picker(
                        "",
                        selection: $selectedState
                    ) {
                        ForEach(
                            TaskSection.allCases,
                            id: \.self
                        ) { option in
                            if option != .all {
                                Text(
                                    option.localized
                                )
                                .tag(
                                    option.localized
                                )
                            }
                        }
                    }
                    .pickerStyle(
                        .menu
                    )
                    .task(
                        id: selectedState
                    ) {
                        appEnvironment.realm?.writeAsync({
                            guard let thaw = task.thaw() else {
                                task.status = selectedState.rawValue
                                return
                            }
                            thaw.status = selectedState.rawValue
                        })
                    }
                }
            }
        )
    }
    /// section body.
    @ViewBuilder
    private func sectionBody() -> AnyView {
        AnyView(
            Section {
                TextField(
                    task.text,
                    text: $task.text,
                    axis: .vertical
                )
            } header: {
                HStack {
                    Text(
                        "taskView_board_task_body".localized
                    )
                    Image(
                        systemName: "note.text"
                    )
                }
            }
        )
    }
    /// section attachments.
    @ViewBuilder
    private func sectionAttachments() -> AnyView {
        AnyView(
            Section {
                ForEach(
                    0..<task.attachments.count,
                    id: \.self
                ) { index in
                    TextField(
                        task.attachments[index],
                        text: Binding(
                            get: {
                                task.attachments[index]
                            },
                            set: { (value) in
                                appEnvironment.realm?.writeAsync(
                                    {
                                        guard let thaw = task.thaw() else {
                                            task.attachments[index] = value
                                            return
                                        }
                                        thaw.attachments[index] = value
                                    }
                                )
                            }
                        ),
                        axis: .vertical
                    )
                    .keyboardType(
                        .URL
                    )
                    .textContentType(
                        .URL
                    )
                }
                .onDelete { indexSet in
                    appEnvironment.realm?.writeAsync(
                        {
                            guard let thaw = task.thaw() else {
                                task.attachments.remove(
                                    atOffsets: indexSet
                                )
                                return
                            }
                            thaw.attachments.remove(
                                atOffsets: indexSet
                            )
                        }
                    )
                }
                Button {
                    appEnvironment.realm?.writeAsync(
                        {
                            guard let thaw = task.thaw() else {
                                $task.attachments.append(
                                    ""
                                )
                                return
                            }
                            thaw.attachments.append(
                                ""
                            )
                        }
                    )
                } label: {
                    Text(
                        "taskView_board_task_add_attachment".localized
                    )
                }
            } header: {
                HStack {
                    Text(
                        "taskView_board_task_attachment".localized
                    )
                    Image(
                        systemName: "link"
                    )
                }
            }
        )
    }
    /// section task.
    @ViewBuilder
    private func sectionTask() -> AnyView {
        AnyView(
            Section {
                ForEach(
                    $task.boardSubTasks,
                    id: \.self
                ) { element in
                    HStack {
                        TaskBoardButtonDetailView(
                            subTask: element.wrappedValue,
                            selectedIndex: element.wrappedValue.isComplete
                        )
                        TextField(
                            element.text.wrappedValue,
                            text: element.text,
                            axis: .vertical
                        )
                    }
                }
                .onDelete { indexSet in
                    appEnvironment.realm?.writeAsync(
                        {
                            guard let thaw = task.thaw() else {
                                task.boardSubTasks.remove(
                                    atOffsets: indexSet
                                )
                                return
                            }
                            thaw.boardSubTasks.remove(
                                atOffsets: indexSet
                            )
                        }
                    )
                }
                Button {
                    appEnvironment.realm?.writeAsync(
                        {
                            let boardSubTask = BoardSubTask(
                                boardTask_id: task._id,
                                isComplete: false,
                                shared_id: task.shared_id,
                                text: ""
                            )
                            guard let thaw = task.thaw() else {
                                $task.boardSubTasks.append(
                                    boardSubTask
                                )
                                return
                            }
                            thaw.boardSubTasks.append(
                                boardSubTask
                            )
                        }
                    )
                } label: {
                    Text(
                        "taskView_baard_menu_action_add".localized
                    )
                }
            } header: {
                HStack {
                    Text(
                        "taskView_board_task_tasks".localized
                    )
                    Image(
                        systemName: "list.bullet"
                    )
                }
            }
        )
    }
    /// section comments.
    @ViewBuilder
    private func sectionComments() -> AnyView {
        AnyView(
            Section {
                ForEach(
                    0..<task.comments.count,
                    id: \.self
                ) { index in
                    TextField(
                        task.comments[index],
                        text: Binding(
                            get: {
                                task.comments[index]
                            },
                            set: { (value) in
                                appEnvironment.realm?.writeAsync(
                                    {
                                        guard let thaw = task.thaw() else {
                                            task.comments[index] = value
                                            return
                                        }
                                        thaw.comments[index] = value
                                    }
                                )
                            }
                        ),
                        axis: .vertical
                    )
                }
                .onDelete { indexSet in
                    appEnvironment.realm?.writeAsync(
                        {
                            guard let thaw = task.thaw() else {
                                task.comments.remove(
                                    atOffsets: indexSet
                                )
                                return
                            }
                            thaw.comments.remove(
                                atOffsets: indexSet
                            )
                        }
                    )
                }
                Button {
                    appEnvironment.realm?.writeAsync(
                        {
                            guard let thaw = task.thaw() else {
                                $task.comments.append(
                                    ""
                                )
                                return
                            }
                            thaw.comments.append(
                                ""
                            )
                        }
                    )
                } label: {
                    Text(
                        "taskView_board_task_add_comment".localized
                    )
                }
            } header: {
                HStack {
                    Text(
                        "taskView_board_task_comment".localized
                    )
                    Image(
                        systemName: "text.bubble.fill"
                    )
                }
            }
        )
    }
}
