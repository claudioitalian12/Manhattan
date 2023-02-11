//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 18/12/22.
//

import SwiftUI

// MARK: Extension String
extension String {
    /// var localized
    var localized: String {
        NSLocalizedString(
            self,
            bundle: Bundle.module,
            comment: ""
        )
    }
}
