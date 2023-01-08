//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 30/12/22.
//

import Foundation

enum Period: CaseIterable, Identifiable {
    case nextSevenDays
    case nextThirtyDays
    case future
    case past
    
    var id: String {
        switch self {
        case .nextSevenDays:
            return "profileView_profile_list_section_next7".localized
        case .nextThirtyDays:
            return "profileView_profile_list_section_next30".localized
        case .future:
            return "profileView_profile_list_section_future".localized
        case .past:
            return "profileView_profile_list_section_past".localized
        }
    }
    
    var name: String {
        switch self {
        case .nextSevenDays:
            return "profileView_profile_list_section_next7".localized
        case .nextThirtyDays:
            return "profileView_profile_list_section_next30".localized
        case .future:
            return "profileView_profile_list_section_future".localized
        case .past:
            return "profileView_profile_list_section_past".localized
        }
    }
}
