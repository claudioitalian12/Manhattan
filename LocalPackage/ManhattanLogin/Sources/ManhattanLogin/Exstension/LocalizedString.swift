//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 05/12/22.
//

import SwiftUI

extension String {
    var localized: String {
        NSLocalizedString(
            self,
            bundle: Bundle.module,
            comment: ""
        )
    }
}
