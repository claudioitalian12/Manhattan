//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 30/12/22.
//

import SwiftUI

// MARK: EventRowImageViewModifier
struct EventRowImageViewModifier: ViewModifier {
    let color: Color
    let maxWidth: CGFloat = 50.0
    
    func body(
        content: Content
    ) -> some View {
        content
            .imageScale(.large)
            .symbolRenderingMode(.monochrome)
            .foregroundStyle(color)
            .frame(
                maxWidth: maxWidth,
                alignment: .leading
            )
    }
}

extension Image {
    func customEventRowImage(
        color: Color
    ) -> some View {
        modifier(
            EventRowImageViewModifier(
                color: color
            )
        )
    }
}

// MARK: EventRowDateTextViewModifier
struct EventRowDateTextViewModifier: ViewModifier {
    
    func body(
        content: Content
    ) -> some View {
        content
            .font(.caption2)
            .foregroundStyle(.secondary)
            .frame(
                maxWidth: .infinity,
                alignment: .leading
            )
    }
}

extension Text {
    func customEventRowDateText() -> some View {
        modifier(
            EventRowDateTextViewModifier()
        )
    }
}

// MARK: EventRowTitleTextViewModifier
struct EventRowTitleTextViewModifier: ViewModifier {
    
    func body(
        content: Content
    ) -> some View {
        content
            .fontWeight(.bold)
            .frame(
                maxWidth: .infinity,
                alignment: .leading
            )
    }
}

extension Text {
    func customEventRowTitleText() -> some View {
        modifier(
            EventRowTitleTextViewModifier()
        )
    }
}

// MARK: EventRowCompliteTaskImageViewModifier
struct EventRowCompliteTaskImageViewModifier: ViewModifier {
    
    func body(
        content: Content
    ) -> some View {
        content
            .foregroundStyle(.secondary)
    }
}

extension Image {
    func customEventCompliteTaskImage() -> some View {
        modifier(
            EventRowCompliteTaskImageViewModifier()
        )
    }
}

// MARK: EventRowHstackViewModifier
struct EventRowHstackViewModifier: ViewModifier {
    let remainingTaskCount: Int
    
    func body(
        content: Content
    ) -> some View {
        content
            .badge(remainingTaskCount)
    }
}

extension HStack {
    func customEventHstack(
        remainingTaskCount: Int
    ) -> some View {
        modifier(
            EventRowHstackViewModifier(
                remainingTaskCount: remainingTaskCount
            )
        )
    }
}
