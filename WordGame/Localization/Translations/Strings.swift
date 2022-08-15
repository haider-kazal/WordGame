//
//  Strings.swift
//  WordGame
//
//  Created by Haider Ali Kazal on 13/8/22.
//

protocol StringsProtocol {
    var lookupTableName: String { get }
    var localized: String { get }
}

final class Strings {
    static func text(
        forKey key: String,
        defaultValue: String?,
        fromTable table: String?
    ) -> String {
        let localizedText = LocalizationService.default.localizedText(
            forKey: key,
            defaultValue: defaultValue,
            fromTable: table
        )
        return localizedText
    }
}
