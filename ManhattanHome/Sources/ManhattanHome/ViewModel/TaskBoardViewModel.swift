//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 29/12/22.
//

import ManhattanCore
import SwiftUI

public final class TaskBoardViewModel: ManhattanViewModelProtocol {
    @Published var isLoading = true
    @Published var segmentationSelection: TaskSection = .all

    init(
        homeShowOverlay: Bool = false,
        isLoading: Bool = true,
        segmentationSelection: TaskSection = .all
    ) {
        self.isLoading = isLoading
        self.segmentationSelection = segmentationSelection
    }
    
}
