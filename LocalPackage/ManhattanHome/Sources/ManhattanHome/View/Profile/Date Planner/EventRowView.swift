//
//  File.swift
//
//
//  Created by Claudio Cavalli on 21/12/22.
//

import ManhattanCore
import RealmSwift
import SwiftUI

// MARK: EventRow
struct EventRow: View {
    /// event.
    @State var event: Event
    /// body.
    var body: some View {
        HStack {
            imageRow()
            Spacer()
            stackText()
        }
        .customEventHstack(
            remainingTaskCount: event.remainingTaskCount
        )
    }
    /// image row.
    @ViewBuilder
    func imageRow() -> some View {
        Image(
            systemName: event.symbol
        )
        .customEventRowImage(
            color: event.colorOption
        )
    }
    /// stack text.
    @ViewBuilder
    func stackText() -> some View {
        VStack(
            alignment: .leading,
            spacing: 5.0
        ) {
            Text(
                event.title
            )
            .customEventRowTitleText()
            Text(
                event.dateFormatted
            )
            .customEventRowDateText()
        }
        
        if event.isComplete {
            Spacer()
            Image(
                systemName: "checkmark"
            )
            .customEventCompliteTaskImage()
        }
    }
}
