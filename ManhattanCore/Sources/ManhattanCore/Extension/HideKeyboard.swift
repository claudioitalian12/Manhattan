//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 15/12/22.
//

import SwiftUI

#if canImport(UIKit)
public extension View {
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
