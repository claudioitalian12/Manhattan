//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 23/12/22.
//

import SwiftUI

struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    func makeUIView(
        context: UIViewRepresentableContext<Self>
    ) -> UIVisualEffectView {
        UIVisualEffectView()
    }
    func updateUIView(
        _ uiView: UIVisualEffectView,
        context: UIViewRepresentableContext<Self>
    ) {
        uiView.effect = effect
    }
}

public struct OverlayView: View {
    public init() { }
    
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
