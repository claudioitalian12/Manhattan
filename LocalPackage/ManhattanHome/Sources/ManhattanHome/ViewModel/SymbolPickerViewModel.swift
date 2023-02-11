//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 03/01/23.
//

import ManhattanCore
import RealmSwift
import SwiftUI

// MARK: SymbolPickerViewModel
public final class SymbolPickerViewModel: ManhattanViewModelProtocol {
    /// event.
    @ObservedRealmObject var event: Event
    /// selected color.
    @Published var selectedColor: Color = ColorOptions.primary.color
    /// symbol names.
    @Published var symbolNames = EventSymbols.allCases
    /// search input.
    @Published var searchInput = ""
    /**
        Init.

        - Parameter event: event.
        - Parameter selectedColor: selected color.
        - Parameter symbolNames: symbol names.
        - Parameter searchInput: search input.
    */
    init(
        event: Event,
        selectedColor: Color,
        symbolNames: [EventSymbols] = EventSymbols.allCases,
        searchInput: String = ""
    ) {
        self.event = event
        self.selectedColor = selectedColor
        self.symbolNames = symbolNames
        self.searchInput = searchInput
    }
}
