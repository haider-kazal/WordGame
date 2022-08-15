//
//  WordListUseCaseTests.swift
//  PlatformTests
//
//  Created by Haider Ali Kazal on 14/8/22.
//

import XCTest
@testable import Platform

class WordListUseCaseTests: XCTestCase {
    var wordListUseCase: WordListUseCase!
    
    override func setUpWithError() throws {
        let fileURL = Bundle.main
            .url(forResource: "words", withExtension: "json")!
        let repository = WordPairRepository(fromFileURL: fileURL)
        wordListUseCase = .init(repository: repository)
    }

    override func tearDownWithError() throws {
        wordListUseCase = nil
    }

    func test_getDuplicateElements() {
        let wordPairs = wordListUseCase.getResultedWordList(
            numberOfElements: 400,
            correctWordPairRatio: 0.50
        )
        XCTAssertEqual(wordPairs.count, 400, "Got 400 pairs")
    }
    
    func test_getAllCorrectElements() {
        let wordPairs = wordListUseCase.getResultedWordList(
            numberOfElements: 296,
            correctWordPairRatio: 1.0
        )
        
        XCTAssertEqual(wordPairs.count, 296, "Got 296 pairs")
        XCTAssertTrue(wordPairs.allSatisfy({ $0.isCorrect == true }))
    }
    
    func test_getAllIncorrectElements() {
        let wordPairs = wordListUseCase.getResultedWordList(
            numberOfElements: 296,
            correctWordPairRatio: 0.0
        )
        
        XCTAssertEqual(wordPairs.count, 296, "Got 296 pairs")
        XCTAssertTrue(wordPairs.allSatisfy({ $0.isCorrect == false }))
    }

    func test_15ElementsPerformance() {
        // This is an example of a performance test case.
        self.measure {
            _ = wordListUseCase.getResultedWordList(
                numberOfElements: 15,
                correctWordPairRatio: 0.25
            )
        }
    }
    
    func test_296ElementsPerformance() {
        // This is an example of a performance test case.
        self.measure {
            _ = wordListUseCase.getResultedWordList(
                numberOfElements: 296,
                correctWordPairRatio: 0.25
            )
        }
    }
    
    func test_500ElementsPerformance() {
        // This is an example of a performance test case.
        self.measure {
            _ = wordListUseCase.getResultedWordList(
                numberOfElements: 500,
                correctWordPairRatio: 0.25
            )
        }
    }
    
    func test_1000ElementsPerformance() {
        // This is an example of a performance test case.
        self.measure {
            _ = wordListUseCase.getResultedWordList(
                numberOfElements: 1000,
                correctWordPairRatio: 0.25
            )
        }
    }
}
