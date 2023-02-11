//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 09/12/22.
//

import Foundation

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
