//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 05/12/22.
//

import SwiftUI

// MARK: String
extension String {
    /// localized
    var localized: String {
        NSLocalizedString(
            self,
            bundle: Bundle.module,
            comment: ""
        )
    }
}
