//
//  File.swift
//
//
//  Created by Claudio Cavalli on 21/12/22.
//

import SwiftUI

struct SFSymbolStylingViewModifier: ViewModifier {
    
    func body(
        content: Content
    ) -> some View {
        content
            .imageScale(.large)
            .symbolRenderingMode(.monochrome)
    }
}

extension View {
    func sfSymbolStyling() -> some View {
        modifier(
            SFSymbolStylingViewModifier()
        )
    }
}
