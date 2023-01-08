//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 21/12/22.
//

import ManhattanCore
import RealmSwift
import SwiftUI

struct TaskBoardView: View {
    @Environment(\.appEnvironmentValue) var appEnvironment: AppEnvironment
    @ObservedObject var viewModel: TaskBoardViewModel
    @StateRealmObject var boardsData: BoardsData = BoardsData()
    @State private var selection = Board()
    @State private var showAddBoard = false
    @State private var boardName = ""
    @State private var boardID = ""
    
    init(
        viewModel: TaskBoardViewModel
    ){
        self.viewModel = viewModel
        
        UISegmentedControl.appearance().backgroundColor = .systemBlue
        UISegmentedControl.appearance().setTitleTextAttributes(
            [.foregroundColor: UIColor.white],
            for: .selected
        )
        UISegmentedControl.appearance().setTitleTextAttributes(
            [.foregroundColor: UIColor.white],
            for: .normal
        )
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor.white.withAlphaComponent(0.2)
    }
    
    var body: some View {
        VStack(
            spacing: 40.0
        ) {
            viewBoardHeader()
            viewBoardTasks()
        }
        .frame(
            maxWidth: .infinity
        )
        .task(
            id: appEnvironment.realm
        ) {
            guard let list = appEnvironment.realm?.objects(BoardsData.self),
                  let myList = list.first else {
                return
            }
            boardsData = myList
            selection = myList.boards.first ?? Board()
        }
        .sheet(isPresented: $showAddBoard) {
            NavigationStack {
                VStack {
                    TextField("board Name", text: $boardName)
                    TextField("board user ID", text: $boardID)
                }
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
                            showAddBoard.toggle()
                        } label: {
                            Text("done")
                        }
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private func viewBoardHeader() -> some View {
        VStack {
            viewHeader()
            viewSegmentBoard()
            viewSegmentStatus()
        }
        .frame(
            maxWidth: .infinity
        )
    }
    
    @ViewBuilder
    private func viewHeader() -> some View {
        HStack(
            alignment: .center
        ) {
            Text("Spritz Board")
                .customTaskBoardText(
                    font: .largeTitle
                )
            Button {
                showAddBoard.toggle()
                //addBoard()
            } label: {
                Image(
                    systemName: "plus.circle"
                )
            }
        }
    }
    
    @ViewBuilder
    private func viewSegmentBoard() -> some View {
        if boardsData.boards.count != 0 {
            Picker(
                "Select a board",
                selection: $selection
            ) {
                ForEach(
                    boardsData.boards,
                    id: \.self
                ) {
                    Text($0.title)
                }
            }
            .pickerStyle(.menu)
        }
    }
    
    @ViewBuilder
    private func viewSegmentStatus() -> some View {
        Picker(
            "",
            selection: $viewModel.segmentationSelection
        ) {
            ForEach(
                TaskSection.allCases,
                id: \.self
            ) { option in
                Text(option.rawValue)
            }
        }
        .customTaskBoardPicker()
    }
    
    @ViewBuilder
    private func viewBoardTasks() -> some View {
        ScrollView {
            ForEach(selection.boardTasks) { boardTask in
                TaskBoardCardCardView()
            }
        }
        .customTaskBoardScrollView()
    }
    
    private func addBoard() {
        var listId = RealmSwift.List<String>()
        listId.append(appEnvironment.getDatabaseUser()!.id)
        listId.append("63b8aa0b7c22118af8f9c196")

        var task = RealmSwift.List<BoardTask>()
        var boardTask = BoardTask(
            _id: ObjectId.generate(),
            board_id: ObjectId.generate(),
            owner_id: appEnvironment.getDatabaseUser()!.id,
            shared_id: listId,
            status: "Closed",
            text: "dewefefew",
            title: "ewfefefer"
        )
        task.append(boardTask)
        var board = Board(
            _id: ObjectId.generate(),
            boardTasks: task,
            owner_id: appEnvironment.getDatabaseUser()!.id,
            shared_id: listId,
            title: "MySuperBoard"
        )
        var boardList = RealmSwift.List<Board>()
        boardList.append(board)
        appEnvironment.realm?.writeAsync({
            appEnvironment.realm?.add(
                BoardsData(
                    _id: ObjectId.generate(),
                    boards: boardList,
                    owner_id: appEnvironment.getDatabaseUser()!.id
                )
            )
        }, onComplete: { error in
            guard let list = self.appEnvironment.realm?.objects(BoardsData.self),
                  let myList = list.first else {
                return
            }
            self.boardsData = myList
            self.selection = myList.boards.first ?? Board()
        })
    }
}


