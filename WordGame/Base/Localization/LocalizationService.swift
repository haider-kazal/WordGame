//
//  LocalizationService.swift
//  WordGame
//
//  Created by Haider Ali Kazal on 13/8/22.
//

import Foundation

final class LocalizationService {
    private let numberFormatter = NumberFormatter()
    
    private(set) var bundle: Bundle
    
    private(set) var language: AppLanguage {
        get {
            guard let languageRawValue =
                    UserDefaults.standard.string(forKey: "appLanguage") else {
                return .english
            }
            
            let appLanguage = AppLanguage(rawValue: languageRawValue)
            return appLanguage ?? .english
        }
        
        set(newValue) {
            UserDefaults.standard.set(newValue.rawValue, forKey: "appLanguage")
        }
    }
    
    static let `default` = LocalizationService()
    
    private init() {
        guard let languageRawValue =
                UserDefaults.standard.string(forKey: "appLanguage"),
              let appLanguage = AppLanguage(rawValue: languageRawValue),
              let localizationPath =
                Bundle.main.path(forResource: appLanguage.rawValue, ofType: "lproj"),
              let localizedBundle = Bundle(path: localizationPath) else {
            bundle = .main
            language = .english
            return
        }
        
        bundle = localizedBundle
    }
    
    func localizedText(
        forKey key: String,
        defaultValue: String?,
        fromTable table: String?
    ) -> String {
        let text = bundle
            .localizedString(forKey: key, value: defaultValue, table: table)
        return text
    }
    
    func localizedNumber(_ number: Int) -> String {
        numberFormatter.locale = Locale(identifier: language.rawValue)
        let numberString = numberFormatter.string(from: NSNumber(value: number))
        return numberString ?? String(number)
    }
    
    @discardableResult
    func setNewLanguage(_ language: AppLanguage) -> Bool {
        guard let localizationPath =
                Bundle.main.path(forResource: language.rawValue, ofType: "lproj"),
              let localizedBundle = Bundle(path: localizationPath) else {
            bundle = .main
            self.language = .english
            postLanguageUpdatedNotification()
            return false
        }
        
        bundle = localizedBundle
        self.language = language
        postLanguageUpdatedNotification()
        return true
    }
    
    private func postLanguageUpdatedNotification() {
        NotificationCenter.default.post(
            name: Constants.NotificationNames.appUpdatedLanguage,
            object: nil
        )
    }
}

