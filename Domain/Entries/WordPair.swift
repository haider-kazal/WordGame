//
//  WordPair.swift
//  Domain
//
//  Created by Haider Ali Kazal on 10/8/22.
//

public struct WordPair: Codable, Equatable {
    public let englishWord: String
    public let spanishWord: String
    
    enum CodingKeys: String, CodingKey {
        case englishWord = "text_eng"
        case spanishWord = "text_spa"
    }
    
    public init(englishWord: String, spanishWord: String) {
        self.englishWord = englishWord
        self.spanishWord = spanishWord
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.englishWord == rhs.englishWord &&
            lhs.spanishWord == rhs.spanishWord
    }
}
