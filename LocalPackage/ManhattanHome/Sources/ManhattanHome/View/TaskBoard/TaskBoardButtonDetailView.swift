//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 11/02/23.
//

import ManhattanCore
import RealmSwift
import SwiftUI

// MARK: TaskBoardButtonDetailView
struct TaskBoardButtonDetailView: View {
    /// app environment.
    @Environment(\.appEnvironmentValue) var appEnvironment: AppEnvironment
    /// sub task.
    @State var subTask: BoardSubTask
    /// selected index.
    @State var selectedIndex: Bool = false
    /// body.
    var body: some View {
        Button {
            appEnvironment.realm?.writeAsync({
                guard let thaw = subTask.thaw() else {
                    subTask.isComplete.toggle()
                    return
                }
                thaw.isComplete.toggle()
            }, onComplete: { _ in
                selectedIndex = !selectedIndex
             }
            )
        } label: {
            Image(
                systemName: selectedIndex ? "checkmark.circle.fill":"circle"
            )
        }
        .buttonStyle(.plain)
    }
}
