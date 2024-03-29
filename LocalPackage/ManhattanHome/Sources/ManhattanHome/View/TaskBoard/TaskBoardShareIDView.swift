//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 08/01/23.
//

import ManhattanCore
import RealmSwift
import SwiftUI

// MARK: TaskBoardShareIDView
struct TaskBoardShareIDView: View {
    /// share ID.
    @Binding var shareId: String
    /// body.
    var body: some View {
        TextField(
            "taskView_board_menu_share".localized,
            text: $shareId,
            axis: .vertical
        )
    }
}
