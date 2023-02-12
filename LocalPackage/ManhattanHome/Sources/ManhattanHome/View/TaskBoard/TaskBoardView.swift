//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 21/12/22.
//

import ManhattanCore
import RealmSwift
import SwiftUI

// MARK: TaskBoardTextViewModifier
struct TaskBoardView: View {
    /// app environment.
    @Environment(\.appEnvironmentValue) var appEnvironment: AppEnvironment
    /// view model.
    @ObservedObject var viewModel: TaskBoardViewModel
    /// boards data.
    @StateRealmObject var boardsData: BoardsData = BoardsData()
    /// selection.
    @State private var selection = Board()
    /// show add board.
    @State private var showAddBoard = false
    /// add task.
    @State private var addTask = false
    /// show detail.
    @State private var showDetail = false
    /// list order latest.
    @State private var listOrderLatest = true
    /**
     Init.
     
     - Parameter viewModel: view model.
     */
    init(
        viewModel: TaskBoardViewModel
    ){
        self.viewModel = viewModel
        
        UISegmentedControl
            .appearance()
            .backgroundColor = .systemBlue
        UISegmentedControl
            .appearance()
            .setTitleTextAttributes(
                [
                    .foregroundColor: UIColor.white
                ],
                for: .selected
            )
        UISegmentedControl
            .appearance()
            .setTitleTextAttributes(
                [
                    .foregroundColor: UIColor.white
                ],
                for: .normal
            )
        UISegmentedControl
            .appearance()
            .selectedSegmentTintColor = UIColor.white.withAlphaComponent(
                0.2
            )
    }
    /// body.
    var body: some View {
        VStack {
            viewBoardHeader()
            Spacer(
                minLength: 40.0
            )
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
    /// load boards.
    private func loadBoards() {
        guard let list = appEnvironment.realm?.objects(BoardsData.self),
              let myList = list.first else {
            boardsData.owner_id = appEnvironment.getUserID()
            appEnvironment.realm?.writeAsync(
                {
                    appEnvironment.realm?.add(
                        boardsData
                    )
                },
                onComplete: { error in
                    guard let boardsObject = appEnvironment.realm?.objects(Board.self) else {
                        return
                    }
                    boardsData.boards.append(
                        objectsIn: boardsObject
                    )
                }
            )
            return
        }
        boardsData = myList
        selection = myList.boards.first ?? Board()
        appEnvironment.realm?.objects(Board.self).forEach(
            { board in
                if board.owner_id != appEnvironment.getUserID() && !boardsData.boards.contains(
                    where: { boardObject in
                        boardObject._id == board._id
                    }
                ) {
                    appEnvironment.realm?.writeAsync(
                        {
                            $boardsData.boards.append(
                                board
                            )
                        }
                    )
                }
            }
        )
        addTask.toggle()
    }
    /// refresh list.
    private func refreshList() async {
        let tempSelect = selection
        guard let list = appEnvironment.realm?.objects(BoardsData.self),
              let myList = list.first else {
            boardsData.owner_id = appEnvironment.getUserID()
            appEnvironment.realm?.writeAsync(
                {
                    appEnvironment.realm?.add(
                        boardsData
                    )
                },
                onComplete: { error in
                    guard let boardsObject = appEnvironment.realm?.objects(Board.self) else {
                        return
                    }
                    boardsData.boards.append(
                        objectsIn: boardsObject
                    )
                    addTask.toggle()
                }
            )
            return
        }
        boardsData = myList
        selection = tempSelect
        appEnvironment.realm?.objects(Board.self).forEach(
            { board in
                if board.owner_id != appEnvironment.getUserID() && !boardsData.boards.contains(
                    where: { boardObject in
                        boardObject._id == board._id
                    }
                ) {
                    appEnvironment.realm?.writeAsync(
                        {
                            $boardsData.boards.append(
                                board
                            )
                        },
                        onComplete: { _ in
                            addTask.toggle()
                        }
                    )
                }
            }
        )
        addTask.toggle()
    }
    /// view board header.
    @ViewBuilder
    private func viewBoardHeader() -> some View {
        viewHeader()
        viewSegmentStatus()
    }
    /// view header.
    @ViewBuilder
    private func viewHeader() -> some View {
        HStack(
            alignment: .center,
            spacing: 20.0
        ) {
            Text(
                "taskView_board_title".localized
            )
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
                        Text(
                            "taskView_board_menu_create".localized
                        )
                        Image(
                            systemName: "clipboard"
                        )
                    }
                    if boardsData.boards.count != 0 {
                        TaskBoardAddTaskView(
                            board: $selection,
                            addTask: $addTask
                        )
                    }
                } label: {
                    Image(
                        systemName: "plus.circle"
                    )
                    .foregroundColor(
                        .blue
                    )
                }
                viewBoardMenu()
                viewOrderTask()
            }
        }
    }
    /// view board menu.
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
                    Text(
                        index.title
                    )
                }
            }
        } label: {
            Image(
                systemName: "list.bullet"
            )
            .foregroundColor(
                .blue
            )
        }
    }
    /// view order task.
    @ViewBuilder
    private func viewOrderTask() -> some View {
        Menu {
            Button {
                listOrderLatest = true
                addTask.toggle()
            } label: {
                Text(
                    "taskView_board_menu_latest".localized
                )
                Image(
                    systemName: "hourglass.tophalf.filled"
                )
            }
            Button {
                listOrderLatest = false
                addTask.toggle()
            } label: {
                Text(
                    "taskView_board_menu_oldest".localized
                )
                Image(
                    systemName: "hourglass.bottomhalf.filled"
                )
            }
        } label: {
            Image(
                systemName: "arrow.up.arrow.down"
            )
            .foregroundColor(
                .blue
            )
        }
    }
    /// view segment status.
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
                Text(
                    option.rawValue
                )
                .tag(
                    option.rawValue
                )
            }
        }
        .customTaskBoardPicker()
    }
    /// view board tasks.
    @ViewBuilder
    private func viewBoardTasks() -> some View {
        if addTask == true || addTask == false, listOrderLatest {
            ForEach(
                $selection.boardTasks.reversed()
            ) { index in
                if viewModel.segmentationSelection.rawValue == index.status.wrappedValue ||
                    viewModel.segmentationSelection == .all {
                    TaskBoardCardView(
                        task: index,
                        doneTask: $addTask
                    )
                }
            }
        } else {
            ForEach(
                $selection.boardTasks
            ) { index in
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
