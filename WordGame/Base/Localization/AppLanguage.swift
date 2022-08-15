//
//  AppLanguage.swift
//  WordGame
//
//  Created by Haider Ali Kazal on 13/8/22.
//

enum AppLanguage: String, CaseIterable {
    case english = "en"
    
    var asString: String {
        switch self {
        case .english:
            return "English"
        }
    }
    
    var isSelected: Bool { LocalizationService.default.language == self }
}
