//
//  File.swift
//
//
//  Created by Claudio Cavalli on 21/12/22.
//

import ManhattanCore
import RealmSwift
import SwiftUI

// MARK: SymbolPicker
struct SymbolPicker: View {
    /// app environment.
    @Environment(\.appEnvironmentValue) var appEnvironment: AppEnvironment
    /// view model.
    @ObservedObject var viewModel: SymbolPickerViewModel
    /// dismiss.
    @Environment(\.dismiss) private var dismiss
    /// columns.
    var columns = Array(
        repeating: GridItem(
            .flexible()
        ),
        count: 6
    )
    /// body.
    var body: some View {
        VStack {
            stackDismissButton()
            stackSelectedIcon()
            stackColorList()
            Divider()
            gridIcon()
        }
        .onAppear {
            viewModel.selectedColor = viewModel.event.colorOption
        }
    }
    /// stack dismiss button.
    @ViewBuilder
    func stackDismissButton() -> some View {
        HStack {
            Spacer()
            Button {
                dismiss()
            } label: {
                Text(
                    "eventEditorView_profile_navigation_done_button".localized
                )
            }
            .padding()
        }
    }
    /// stack selected icon.
    @ViewBuilder
    func stackSelectedIcon() -> some View {
        HStack {
            Image(
                systemName: viewModel.event.symbol
            )
            .font(
                .title
            )
            .imageScale(
                .large
            )
            .foregroundColor(
                viewModel.selectedColor
            )
        }
        .padding()
    }
    /// stack color list.
    @ViewBuilder
    func stackColorList() -> some View {
        HStack {
            ForEach(
                ColorOptions.allCases,
                id: \.self
            ) { colorOption in
                Button {
                    viewModel.selectedColor = colorOption.color
                    guard let eventColor = viewModel.event.realm else {
                        appEnvironment.realm?.writeAsync(
                            {
                                viewModel.event.color = colorOption.rawValue
                            }
                        )
                        return
                    }
                    eventColor.thaw().writeAsync(
                        {
                            viewModel.event.thaw()?.color = colorOption.rawValue
                        }
                    )
                } label: {
                    Circle()
                        .foregroundColor(
                            colorOption.color
                        )
                }
            }
        }
        .padding(
            .horizontal
        )
        .frame(
            height: 40.0
        )
    }
    /// grid icon.
    @ViewBuilder
    func gridIcon() -> some View {
        ScrollView {
            LazyVGrid(
                columns: columns
            ) {
                ForEach(
                    viewModel.symbolNames,
                    id: \.self
                ) { symbolItem in
                    Button {
                        guard let eventSymbol = viewModel.event.realm else {
                            appEnvironment.realm?.writeAsync(
                                {
                                    viewModel.event.symbol = symbolItem.rawValue
                                }
                            )
                            return
                        }
                        eventSymbol.thaw().writeAsync(
                            {
                                viewModel.event.thaw()?.symbol = symbolItem.rawValue
                            }
                        )
                    } label: {
                        Image(
                            systemName: symbolItem.rawValue
                        )
                        .sfSymbolStyling()
                        .foregroundColor(
                            viewModel.selectedColor
                        )
                        .padding(
                            5.0
                        )
                    }
                    .buttonStyle(
                        .plain
                    )
                }
            }
            .drawingGroup()
        }
    }
}
