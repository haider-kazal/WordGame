//
//  Strings+Game.swift
//  WordGame
//
//  Created by Haider Ali Kazal on 13/8/22.
//

extension Strings {
    enum Game: String, StringsProtocol {
        case correctAttempts = "Game - Correct attempts"
        case wrongAttempts = "Game - Wrong attempts"
        case restart = "Game - Restart"
        case quit = "Game - Quit"
        case score = "Game - Score!"
        
        var lookupTableName: String { "GameLocalizable" }
        
        var localized: String {
            let text = Strings.text(
                forKey: rawValue,
                defaultValue: nil,
                fromTable: lookupTableName
            )
            return text
        }
    }
}
