//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 21/12/22.
//

import ManhattanCore
import SwiftUI

struct TaskBoardCardCardView: View {
    @State var title = ""
    @State var text = ""
    
    var body: some View {
        ZStack {
            RoundedRectangle(
                cornerRadius: 10.0,
                style: .continuous
            )
            .customTaskBoardCardZStack()

            LazyVStack {
                Text(title)
                    .customTaskBoardCardTitleText()

                Text(text)
                    .customTaskBoardCardSubtitleText()
            }
            .customTaskBoardCardLazyVStack()
        }
    }
}
