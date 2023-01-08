//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 09/12/22.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(
            self,
            bundle: Bundle.module,
            comment: ""
        )
    }
}
