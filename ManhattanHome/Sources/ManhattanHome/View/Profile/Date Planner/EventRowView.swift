//
//  File.swift
//
//
//  Created by Claudio Cavalli on 21/12/22.
//

import ManhattanCore
import RealmSwift
import SwiftUI

struct EventRow: View {
    @ObservedRealmObject var event: Event
    
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
    
    @ViewBuilder
    func imageRow() -> some View {
        Image(
            systemName: event.symbol
        )
        .customEventRowImage(
            color: event.colorOption
        )
    }
    
    @ViewBuilder
    func stackText() -> some View {
        VStack(
            alignment: .leading,
            spacing: 5.0
        ) {
            Text(event.title)
                .customEventRowTitleText()
            
            Text(event.dateFormatted)
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
