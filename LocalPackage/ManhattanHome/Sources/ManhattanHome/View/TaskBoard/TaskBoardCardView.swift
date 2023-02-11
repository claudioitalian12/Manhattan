//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 21/12/22.
//

import ManhattanCore
import RealmSwift
import SwiftUI

// MARK: TaskBoardCardView
struct TaskBoardCardView: View {
    /// task.
    @Binding var task: BoardTask
    /// done task.
    @Binding var doneTask: Bool
    /// show detail.
    @State var showDetail = false
    /// body.
    var body: some View {
        ZStack {
            RoundedRectangle(
                cornerRadius: 10.0,
                style: .continuous
            )
            .customTaskBoardCardZStack()
            Button {
                showDetail.toggle()
            } label: {
                LazyVStack {
                    Text(task.title)
                        .customTaskBoardCardTitleText()

                    Text(task.text)
                        .customTaskBoardCardSubtitleText()
                }
                .customTaskBoardCardLazyVStack()
            }
        }
        .sheet(
            isPresented: $showDetail
        ) {
            doneTask.toggle()
        } content: {
            TaskBoardDetailView(
                task: task,
                endEdit: $showDetail,
                selectedState: TaskSection(rawValue: task.status) ?? .all
            )
        }

    }
}
