//
//  TransitionAnimation.swift
//  Manhattan
//
//  Created by Claudio Cavalli on 13/02/23.
//

import SwiftUI

struct TransitionAnimation: ViewModifier {
    func body(
        content: Content
    ) -> some View {
        content
            .transition(
                AnyTransition.move(
                    edge: .leading
                )
                .combined(
                    with: .opacity
                )
                .animation(
                    .easeInOut(
                        duration: 0.5
                    )
                )
            )
    }
}

extension View {
    func transitionAnimation() -> some View {
        modifier(
            TransitionAnimation()
        )
    }
}
