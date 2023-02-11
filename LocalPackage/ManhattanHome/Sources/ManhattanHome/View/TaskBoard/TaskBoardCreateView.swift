//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 08/01/23.
//

import ManhattanCore
import RealmSwift
import SwiftUI

// MARK: TaskBoardCreateView
struct TaskBoardCreateView: View {
    /// app environment.
    @Environment(\.appEnvironmentValue) var appEnvironment: AppEnvironment
    /// board.
    @ObservedRealmObject var board: Board = Board()
    /// selection.
    @Binding var selection: Board
    /// show add board.
    @Binding var showAddBoard: Bool
    /// users id.
    @State var usersID: [String] = []
    /// body.
    var body: some View {
        NavigationStack {
            boardList()
                .toolbar {
                    ToolbarItem(
                        placement: .cancellationAction
                    ) {
                        Button {
                            showAddBoard.toggle()
                        } label: {
                            Text("cancel")
                        }
                    }
                    ToolbarItem {
                        Button {
                            didTapDone()
                        } label: {
                            Text("done")
                        }
                    }
                }
        }
    }
    /// board list.
    @ViewBuilder
    private func boardList() -> some View {
        List {
            Section {
                ForEach(0..<usersID.count, id: \.self) { index in
                    TaskBoardShareIDView(shareId: $usersID[index])
                }
                .onDelete { indexSet in
                    usersID.remove(atOffsets: indexSet)
                }
                Button {
                    usersID.append("")
                } label: {
                    Text("Add ID")
                }
            } header: {
                TextField(
                    "Board Name",
                    text: $board.title
                )
                .font(.title)
                .padding(.all, 20)
                .multilineTextAlignment(.center)
            }
        }
    }
    /// did tap done.
    private func didTapDone() {
        board.owner_id = appEnvironment.getUserID()
        board.shared_id.append(appEnvironment.getUserID() ?? "")
        board.shared_id.append(objectsIn: usersID)
        guard let list = self.appEnvironment.realm?.objects(BoardsData.self),
              let myList = list.first else {
            return
        }
        
        appEnvironment.realm?.writeAsync({
            myList.boards.append(board)
        }, onComplete: { error in
            selection = board
        })
        
        showAddBoard.toggle()
    }
}
