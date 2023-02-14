//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 29/12/22.
//

import ManhattanCore
import SwiftUI

// MARK: TaskBoardViewModel
public final class TaskBoardViewModel: ManhattanViewModelProtocol {
    /// is loading.
    @Published var isLoading = true
    /// segmentation selection.
    @Published var segmentationSelection: TaskSection = .all
    /**
        Init.

        - Parameter isLoading: is loading.
        - Parameter segmentationSelection: segmentation selection.
    */
    init(
        isLoading: Bool = true,
        segmentationSelection: TaskSection = .all
    ) {
        self.isLoading = isLoading
        self.segmentationSelection = segmentationSelection
    }
    
}
