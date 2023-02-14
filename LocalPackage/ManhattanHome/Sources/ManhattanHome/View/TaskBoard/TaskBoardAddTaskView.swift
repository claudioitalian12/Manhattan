//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 08/01/23.
//

import ManhattanCore
import RealmSwift
import SwiftUI

// MARK: TaskBoardAddTaskView
struct TaskBoardAddTaskView: View {
    /// app environment.
    @Environment(\.appEnvironmentValue) var appEnvironment: AppEnvironment
    /// board.
    @Binding var board: Board
    /// add task.
    @Binding var addTask: Bool
    /// body.
    var body: some View {
        Button {
            let boardTask = BoardTask(
                assigned_id: appEnvironment.getUserID(),
                attachments: RealmSwift.List<String>(),
                boardSubTasks: RealmSwift.List<BoardSubTask>(),
                board_id: board._id,
                comments: RealmSwift.List<String>(),
                owner_id: appEnvironment.getUserID(),
                shared_id: board.shared_id,
                status: "taskView_board_status_new",
                text: "taskView_baard_task_title".localized,
                title: "taskView_baard_task_title".localized
            )

            appEnvironment.realm?.writeAsync(
                {
                    appEnvironment.realm?.add(
                        boardTask
                    )
                    $board.boardTasks.append(
                        boardTask
                    )
                },
                onComplete: { _ in
                    addTask.toggle()
                }
            )
        } label: {
            Text(
                "taskView_baard_menu_action_add".localized
            )
            Image(
                systemName: "plus.square"
            )
        }
    }
}
