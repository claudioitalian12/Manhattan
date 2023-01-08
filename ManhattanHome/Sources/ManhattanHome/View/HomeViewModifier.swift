//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 18/12/22.
//

import ManhattanCore
import SwiftUI

// MARK: HomeNavigationStackModifier
struct HomeNavigationStackModifier: ViewModifier {
    @Binding var isOverlayHidden: Bool
    
    func body(
        content: Content
    ) -> some View {
        content
            .padding()
            .overlay {
                OverlayView()
                    .opacity(
                        isOverlayHidden ? 1 : 0
                    )
            }
    }
}

extension NavigationStack {
    func customNavigationStack(
        isOverlayHidden: Binding<Bool>
    ) -> some View {
        modifier(
            HomeNavigationStackModifier(
                isOverlayHidden: isOverlayHidden
            )
        )
    }
}

// MARK: HomeTabViewModifier
struct HomeTabViewModifier: ViewModifier {
    
    func body(
        content: Content
    ) -> some View {
        content
            .tabViewStyle(.page)
            .indexViewStyle(
                PageIndexViewStyle(
                    backgroundDisplayMode: .always
                )
            )
            .indexViewStyle(
                PageIndexViewStyle()
            )
    }
}

extension TabView {
    func customTabViewHome() -> some View {
        modifier(
            HomeTabViewModifier()
        )
    }
}

// MARK: HStackViewModifier
struct HStackViewModifier: ViewModifier {
    
    func body(
        content: Content
    ) -> some View {
        content
            .frame(
                maxWidth: .infinity
            )
    }
}

extension HStack {
    func customHStackHome() -> some View {
        modifier(
            HStackViewModifier()
        )
    }
}
