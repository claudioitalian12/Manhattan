//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 03/01/23.
//

import ManhattanCore
import RealmSwift
import SwiftUI

public final class SymbolPickerViewModel: ManhattanViewModelProtocol {
    @ObservedRealmObject var event: Event
    @Published var selectedColor: Color = ColorOptions.primary.color
    @Published var symbolNames = EventSymbols.allCases
    @Published var searchInput = ""
    
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
