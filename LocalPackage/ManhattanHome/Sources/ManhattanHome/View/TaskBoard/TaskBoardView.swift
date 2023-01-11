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
    @State private var showDetail = false
    @State private var listOrderLatest = true
    
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
            Spacer(minLength: 40.0)
            ScrollView(
                showsIndicators: false
            ) {
                viewBoardTasks()
            }
            .refreshable {
                await refreshList()
            }
            Spacer(
                minLength: 20.0
            )
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
    
    private func refreshList() async {
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
        addTask.toggle()
    }
    
    @ViewBuilder
    private func viewBoardHeader() -> some View {
        viewHeader()
        viewSegmentStatus()
    }
    
    @ViewBuilder
    private func viewHeader() -> some View {
        HStack(
            alignment: .center,
            spacing: 20.0
        ) {
            Text("Spritz Board")
                .customTaskBoardText(
                    font: .largeTitle
                )
            HStack(
                spacing: 15.0
            ) {
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
                    Image(systemName: "plus.circle")
                        .foregroundColor(.blue)
                }
                viewBoardMenu()
                viewOrderTask()
            }
        }
    }
    
    @ViewBuilder
    private func viewBoardMenu() -> some View {
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
            Image(systemName: "list.bullet")
                .foregroundColor(.blue)
        }
    }
    
    @ViewBuilder
    private func viewOrderTask() -> some View {
        Menu {
            Button {
                listOrderLatest = true
                addTask.toggle()
            } label: {
                Text("Latest")
                Image(systemName: "hourglass.tophalf.filled")
            }
            Button {
                listOrderLatest = false
                addTask.toggle()
            } label: {
                Text("Oldest")
                Image(systemName: "hourglass.bottomhalf.filled")
            }
        } label: {
            Image(systemName: "arrow.up.arrow.down")
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
        if addTask == true || addTask == false, listOrderLatest {
            ForEach($selection.boardTasks.reversed()) { index in
                if viewModel.segmentationSelection.rawValue == index.status.wrappedValue ||
                    viewModel.segmentationSelection == .all {
                    TaskBoardCardView(
                        task: index,
                        doneTask: $addTask
                    )
                }
            }
        } else {
            ForEach($selection.boardTasks) { index in
                if viewModel.segmentationSelection.rawValue == index.status.wrappedValue ||
                    viewModel.segmentationSelection == .all {
                    TaskBoardCardView(
                        task: index,
                        doneTask: $addTask
                    )
                }
            }
        }
    }
}
