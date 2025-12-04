//
//  VoteViewHelper.swift
//  VoteKit
//
//  Created by Maziar Saadatfar on 10/21/23.
//

import Foundation
import UIKit
import ControlKitBase

// Helper function to get localized string without needing UIKit VoteViewConfig
func getLocalizedString(_ localize: LocalString, lang: CKLanguage) -> String {
    guard let localizeString = localize.first(where: { $0.language == lang.rawValue }) else {
        if let defaultLang = localize.first {
            return defaultLang.content ?? ""
        } else {
            return ""
        }
    }
    return localizeString.content ?? ""
}

