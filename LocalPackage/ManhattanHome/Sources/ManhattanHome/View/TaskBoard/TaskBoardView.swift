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

    @State private var addTask = false
    
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
        VStack {
            viewBoardHeader()
            ScrollView(
                showsIndicators: false
            ) {
                viewBoardTasks()
            }
            .refreshable {
                refreshList()
            }
        }
        .task(
            id: appEnvironment.realm
        ) {
            loadBoards()
        }
        .sheet(
            isPresented: $showAddBoard
        ) {
            TaskBoardCreateView(
                selection: $selection,
                showAddBoard: $showAddBoard
            )
        }
    }
    
    private func loadBoards() {
        guard let list = appEnvironment.realm?.objects(BoardsData.self),
              let myList = list.first else {
            boardsData.owner_id = appEnvironment.getUserID()
            appEnvironment.realm?.writeAsync({
                appEnvironment.realm?.add(boardsData)
            }, onComplete: { error in
                guard let boardsObject = appEnvironment.realm?.objects(Board.self) else { return }
                boardsData.boards.append(objectsIn: boardsObject)
            })
            return
        }
        boardsData = myList
        selection = myList.boards.first ?? Board()
        appEnvironment.realm?.objects(Board.self).forEach({ board in
            if board.owner_id != appEnvironment.getUserID() && !boardsData.boards.contains(where: { boardObject in
                boardObject._id == board._id
            }) {
                appEnvironment.realm?.writeAsync({
                    $boardsData.boards.append(board)
                })
            }
        })
        addTask.toggle()
    }
    
    private func refreshList() {
        let tempSelect = selection
        guard let list = appEnvironment.realm?.objects(BoardsData.self),
              let myList = list.first else {
            boardsData.owner_id = appEnvironment.getUserID()
            appEnvironment.realm?.writeAsync({
                appEnvironment.realm?.add(boardsData)
            }, onComplete: { error in
                guard let boardsObject = appEnvironment.realm?.objects(Board.self) else { return }
                boardsData.boards.append(objectsIn: boardsObject)
                addTask.toggle()
            })
            return
        }
        boardsData = myList
        selection = tempSelect
        appEnvironment.realm?.objects(Board.self).forEach({ board in
            if board.owner_id != appEnvironment.getUserID() && !boardsData.boards.contains(where: { boardObject in
                boardObject._id == board._id
            }) {
                appEnvironment.realm?.writeAsync({
                    $boardsData.boards.append(board)
                }, onComplete: { _ in
                    addTask.toggle()
                })
            }
        })
    }
    
    @ViewBuilder
    private func viewBoardHeader() -> some View {
        viewHeader()
        viewSegmentBoard()
        viewSegmentStatus()
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
            Menu {
                Button {
                    showAddBoard.toggle()
                } label: {
                    Text("Create Board")
                    Image(systemName: "clipboard")
                }
                TaskBoardAddTaskView(
                    board: $selection,
                    addTask: $addTask
                )
            } label: {
                Image(systemName: "list.bullet")
                    .foregroundColor(.blue)
            }
        }
    }
    
    @ViewBuilder
    private func viewSegmentBoard() -> some View {
        Menu {
            ForEach(
                boardsData.boards,
                id: \.self
            ) { index in
                Button {
                    selection = index
                } label: {
                    Text(index.title)
                }

            }
        } label: {
            Text(selection.title)
                .frame(maxWidth: .infinity)
                .foregroundColor(.blue)
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
                    .tag(option.rawValue)
            }
        }
        .customTaskBoardPicker()
    }
    
    @ViewBuilder
    private func viewBoardTasks() -> some View {
        if addTask == true || addTask == false {
            ForEach($selection.boardTasks.reversed()) { index in
                if viewModel.segmentationSelection.rawValue == index.status.wrappedValue ||
                    viewModel.segmentationSelection == .all {
                    TaskBoardCardCardView(
                        title: index.title.wrappedValue,
                        text: index.text.wrappedValue
                    )
                }
            }
        }
    }
}
