//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 23/12/22.
//

import SwiftUI

// MARK: VisualEffectView
struct VisualEffectView: UIViewRepresentable {
    /// effect.
    var effect: UIVisualEffect?
    /**
        makeUI View,.

        - Parameter context: context.
    */
    func makeUIView(
        context: UIViewRepresentableContext<Self>
    ) -> UIVisualEffectView {
        UIVisualEffectView()
    }
    /**
        update ui view,.

        - Parameter uiview: ui view.
        - Parameter context: context.
    */
    func updateUIView(
        _ uiView: UIVisualEffectView,
        context: UIViewRepresentableContext<Self>
    ) {
        uiView.effect = effect
    }
}
// MARK: OverlayView
public struct OverlayView: View {
    /// init.
    public init() { }
    /// body.
    public var body: some View {
        ZStack {
            VisualEffectView(
                effect: UIBlurEffect(
                    style: .systemThinMaterialDark
                )
            )
            .edgesIgnoringSafeArea(.all)
            
            ProgressView()
                .progressViewStyle(.circular)
                .colorInvert()
                .brightness(1)
                .padding()
        }
    }
}
