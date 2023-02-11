//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 15/12/22.
//

import SwiftUI

#if canImport(UIKit)
// MARK: View
public extension View {
    /// hide keyboard.
    func hideKeyboard() {
        UIApplication.shared.sendAction(
            #selector(
                UIResponder.resignFirstResponder
            ),
            to: nil,
            from: nil,
            for: nil
        )
    }
}
#endif
