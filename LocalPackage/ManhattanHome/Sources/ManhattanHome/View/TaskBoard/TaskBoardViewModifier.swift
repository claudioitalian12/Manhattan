//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 29/12/22.
//

import SwiftUI

// MARK: TaskBoardTextViewModifier
struct TaskBoardTextViewModifier: ViewModifier {
    let font: Font?
    
    func body(
        content: Content
    ) -> some View {
        content
            .font(.largeTitle)
            .multilineTextAlignment(.center)
    }
}

extension Text {
    func customTaskBoardText(
        font: Font?
    ) -> some View {
        modifier(
            TaskBoardTextViewModifier(font: font)
        )
    }
}

// MARK: TaskBoardPickerViewModifier
struct TaskBoardPickerViewModifier: ViewModifier {
    
    func body(
        content: Content
    ) -> some View {
        content
            .pickerStyle(
                SegmentedPickerStyle()
            )
    }
}

extension Picker {
    func customTaskBoardPicker() -> some View {
        modifier(
            TaskBoardPickerViewModifier()
        )
    }
}

// MARK: TaskBoardScrollViewViewModifier
struct TaskBoardScrollViewViewModifier: ViewModifier {
    
    func body(
        content: Content
    ) -> some View {
        content
            .scrollIndicators(.hidden)
            .frame(
                maxWidth: .infinity
            )
    }
}

extension ScrollView {
    func customTaskBoardScrollView() -> some View {
        modifier(
            TaskBoardScrollViewViewModifier()
        )
    }
}

// MARK: TaskBoardCardTitleTextViewModifier
struct TaskBoardCardTitleTextViewModifier: ViewModifier {
    
    func body(
        content: Content
    ) -> some View {
        content
            .font(.title)
            .opacity(0.5)
            .foregroundColor(.white)
    }
}

extension Text {
    func customTaskBoardCardTitleText() -> some View {
        modifier(
            TaskBoardCardTitleTextViewModifier()
        )
    }
}

// MARK: TaskBoardCardSubtitleTextViewModifier
struct TaskBoardCardSubtitleTextViewModifier: ViewModifier {
    
    func body(
        content: Content
    ) -> some View {
        content
            .font(.body)
            .foregroundColor(.white)
    }
}

extension Text {
    func customTaskBoardCardSubtitleText() -> some View {
        modifier(
            TaskBoardCardSubtitleTextViewModifier()
        )
    }
}

// MARK: TaskBoardCardLazyVStackViewModifier
struct TaskBoardCardLazyVStackViewModifier: ViewModifier {
    
    func body(
        content: Content
    ) -> some View {
        content
            .padding()
            .multilineTextAlignment(.center)
    }
}

extension LazyVStack {
    func customTaskBoardCardLazyVStack() -> some View {
        modifier(
            TaskBoardCardLazyVStackViewModifier()
        )
    }
}

// MARK: RoundedRectangle
extension RoundedRectangle {
    func customTaskBoardCardZStack() -> some View {
        self.fill(.blue)
    }
}
