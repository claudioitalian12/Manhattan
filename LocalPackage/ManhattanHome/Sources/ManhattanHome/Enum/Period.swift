//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 30/12/22.
//

import Foundation

// MARK: Period
enum Period: CaseIterable, Identifiable {
    /// next saven days.
    case nextSevenDays
    /// next thirty days.
    case nextThirtyDays
    /// future.
    case future
    /// past.
    case past
    /// id.
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
    /// name.
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
