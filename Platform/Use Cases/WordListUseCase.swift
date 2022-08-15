//
//  WordListUseCase.swift
//  Platform
//
//  Created by Haider Ali Kazal on 10/8/22.
//

import Domain
import Foundation

public final class WordListUseCase: Domain.WordListUseCase {
    private let wordPairRepository: WordPairRepository
    
    init(repository: WordPairRepository) {
        wordPairRepository = repository
    }
    
    public func getResultedWordList(
        numberOfElements: UInt,
        correctWordPairRatio: Double
    ) -> [ResultedWordPair] {
        wordPairRepository.getWordList(
            expectedElementCount: numberOfElements,
            correctWordPairRatio: correctWordPairRatio
        )
    }
}
