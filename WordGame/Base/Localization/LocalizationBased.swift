//
//  LocalizationBased.swift
//  WordGame
//
//  Created by Haider Ali Kazal on 13/8/22.
//

import UIKit

protocol LocalizationBased {
    func assignLocalizedTexts()
    func setupLocalizationObservers()
}

extension LocalizationBased where Self: UIView {
    func setupLocalizationObservers() {
        NotificationCenter.default.addObserver(
            forName: Constants.NotificationNames.appUpdatedLanguage,
            object: nil,
            queue: .main,
            using: { [weak self] (_) in
                self?.assignLocalizedTexts()
            }
        )
    }
}

extension LocalizationBased where Self: UIViewController {
    func setupLocalizationObservers() {
        NotificationCenter.default.addObserver(
            forName: Constants.NotificationNames.appUpdatedLanguage,
            object: nil,
            queue: .main,
            using: { [weak self] (_) in
                self?.assignLocalizedTexts()
            }
        )
    }
}
