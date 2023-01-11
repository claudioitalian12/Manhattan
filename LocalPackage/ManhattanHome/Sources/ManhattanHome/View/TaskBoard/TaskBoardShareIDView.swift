//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 08/01/23.
//

import ManhattanCore
import RealmSwift
import SwiftUI

struct TaskBoardShareIDView: View {
    @Binding var shareId: String

    var body: some View {
        TextField(
            "board user ID",
            text: $shareId,
            axis: .vertical
        )
    }
}
