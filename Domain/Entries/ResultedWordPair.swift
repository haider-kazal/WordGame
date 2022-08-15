//
//  ResultedWordPair.swift
//  Platform
//
//  Created by Haider Ali Kazal on 10/8/22.
//

public struct ResultedWordPair: Equatable {
    public let wordPair: WordPair
    public let isCorrect: Bool
    
    public init(wordPair: WordPair, isCorrect: Bool) {
        self.wordPair = wordPair
        self.isCorrect = isCorrect
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.wordPair == rhs.wordPair
    }
}
