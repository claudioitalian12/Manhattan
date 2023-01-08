//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 21/12/22.
//

import ManhattanCore
import SwiftUI

struct TaskBoardCardCardView: View {
    
    var body: some View {
        ZStack {
            RoundedRectangle(
                cornerRadius: 10.0,
                style: .continuous
            )
            .customTaskBoardCardZStack()

            LazyVStack {
                Text("My Task Title")
                    .customTaskBoardCardTitleText()

                Text("body of my task is really funny wfnejwfnerfnrekfnrek")
                    .customTaskBoardCardSubtitleText()
            }
            .customTaskBoardCardLazyVStack()
        }
    }
}
