//
//  Constants.swift
//  WordGame
//
//  Created by Haider Ali Kazal on 13/8/22.
//

import Foundation

struct Constants { }

extension Constants {
    struct NotificationNames {
        static let appUpdatedLanguage = Notification.Name(rawValue: "App-Updated-Language")
        
        private init() { }
    }
}

extension Constants {
    struct URLs {
        static let wordsFileURL: URL = Bundle.main
            .url(forResource: "words", withExtension: "json")!
    }
}
