//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 08/01/23.
//

import ManhattanCore
import RealmSwift
import SwiftUI

struct TaskBoardCreateView: View {
    @Environment(\.appEnvironmentValue) var appEnvironment: AppEnvironment
    @ObservedRealmObject var board: Board = Board()
    @Binding var selection: Board
    @Binding var showAddBoard: Bool
    @State var usersID: [String] = []
    
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
