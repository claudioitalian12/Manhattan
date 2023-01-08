//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 08/01/23.
//

import ManhattanCore
import RealmSwift
import SwiftUI

struct TaskBoardAddTaskView: View {
    @Environment(\.appEnvironmentValue) var appEnvironment: AppEnvironment
    @Binding var board: Board
    @Binding var addTask: Bool
    
    var body: some View {
        Button {
            let boardTask = BoardTask(
                assigned_id: appEnvironment.getUserID(),
                board_id: board._id,
                owner_id: appEnvironment.getUserID(),
                shared_id: board.shared_id,
                status: "New",
                text: "New Task",
                title: "New Task"
            )
            
            appEnvironment.realm?.writeAsync({
                appEnvironment.realm?.add(boardTask)
                $board.boardTasks.append(
                    boardTask
                )
            }, onComplete: { _ in
                addTask.toggle()
            })
        } label: {
            Text("Add Task")
            Image(systemName: "plus.square")
        }
    }
}
