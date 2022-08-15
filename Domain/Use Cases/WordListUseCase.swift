//
//  WordListCase.swift
//  Domain
//
//  Created by Haider Ali Kazal on 10/8/22.
//

public protocol WordListUseCase {
    func getResultedWordList(
        numberOfElements: UInt,
        correctWordPairRatio: Double
    ) -> [ResultedWordPair]
}
