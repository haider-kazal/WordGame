//
//  WordPairRepositoryTests.swift
//  PlatformTests
//
//  Created by Haider Ali Kazal on 14/8/22.
//

import Domain
import XCTest
@testable import Platform

class WordPairRepositoryTests: XCTestCase {
    var accurateRepository: WordPairRepository!
    var wrongFileReposity: WordPairRepository!
    
    override func setUpWithError() throws {
        let fileURL = Bundle.main
            .url(forResource: "words", withExtension: "json")!
        
        let wrongFileURL = fileURL
            .deletingLastPathComponent()
            .appendingPathComponent("Words.json")
        
        accurateRepository = .init(fromFileURL: fileURL)
        wrongFileReposity = .init(fromFileURL: wrongFileURL)
    }

    override func tearDownWithError() throws {
        accurateRepository = nil
        wrongFileReposity = nil
    }
    
    func test_accurateRepositoryReadsFileWithoutException() throws {
        XCTAssertNoThrow(try accurateRepository.loadFromFile())
    }
    
    func test_wrongFileRepositoryThrowsError() throws {
        XCTAssertThrowsError(try wrongFileReposity.loadFromFile())
    }
    
    func test_randomIndexesWithSmallRangeBiggerCount() {
        let randomIndexes = accurateRepository.generateRandomIndexes(
            numberOfIndexes: 15,
            fromRange: 0...10
        )
        
        XCTAssertEqual(randomIndexes.count, 15)
    }
    
    func test_randomIndexesWithBiggerRangeSmallCount() {
        let randomIndexes = accurateRepository.generateRandomIndexes(
            numberOfIndexes: 10,
            fromRange: 0...15
        )
        
        XCTAssertEqual(randomIndexes.count, 10)
    }
    
    func test_randomIndexesWithEqualRangeAndCount() {
        let randomIndexes = accurateRepository.generateRandomIndexes(
            numberOfIndexes: 15,
            fromRange: 0...15
        )
        
        XCTAssertEqual(randomIndexes.count, 15)
    }
    
    func test_calculateAllCorrectWordPairElementCount() {
        let count = accurateRepository.calculateCorrectWordPairElementCount(
            totalCount: 15,
            correctWordPairRatio: 1.0
        )
        
        XCTAssertEqual(count, 15)
    }
    
    func test_calculateAllIncorrectWordPairElementCount() {
        let count = accurateRepository.calculateCorrectWordPairElementCount(
            totalCount: 15,
            correctWordPairRatio: 0.0
        )
        
        XCTAssertEqual(count, 0)
    }
    
    func test_calculateHalfCorrectHalfIncorrectWordPairElementCount() {
        let count = accurateRepository.calculateCorrectWordPairElementCount(
            totalCount: 50,
            correctWordPairRatio: 0.50
        )
        
        XCTAssertEqual(count, 25)
    }
    
    func test_wrongPairsWorking() {
        let elements: [WordPair] = [
            .init(englishWord: "A", spanishWord: "A"),
            .init(englishWord: "B", spanishWord: "B"),
            .init(englishWord: "C", spanishWord: "C"),
            .init(englishWord: "D", spanishWord: "D"),
            .init(englishWord: "E", spanishWord: "E"),
            .init(englishWord: "F", spanishWord: "F"),
            .init(englishWord: "G", spanishWord: "G"),
            .init(englishWord: "H", spanishWord: "H"),
            .init(englishWord: "I", spanishWord: "I"),
            .init(englishWord: "J", spanishWord: "J"),
            .init(englishWord: "K", spanishWord: "K"),
            .init(englishWord: "L", spanishWord: "L"),
            .init(englishWord: "M", spanishWord: "M"),
            .init(englishWord: "N", spanishWord: "N"),
            .init(englishWord: "O", spanishWord: "O"),
            .init(englishWord: "P", spanishWord: "P"),
            .init(englishWord: "Q", spanishWord: "Q"),
            .init(englishWord: "R", spanishWord: "R"),
            .init(englishWord: "S", spanishWord: "S"),
            .init(englishWord: "T", spanishWord: "T"),
            .init(englishWord: "U", spanishWord: "U"),
            .init(englishWord: "V", spanishWord: "V"),
            .init(englishWord: "W", spanishWord: "W"),
            .init(englishWord: "X", spanishWord: "X"),
            .init(englishWord: "Y", spanishWord: "Y"),
            .init(englishWord: "Z", spanishWord: "Z")
        ]
        
        let wrongPairs: [[ResultedWordPair]] = Array(
            repeating: accurateRepository.makeWrongPairs(from: elements),
            count: 100
        )
        
        wrongPairs.forEach {
            XCTAssertTrue(
                $0.allSatisfy({
                    $0.wordPair.englishWord != $0.wordPair.spanishWord
                }),
                "\($0.filter({ $0.wordPair.englishWord == $0.wordPair.spanishWord }))")
        }
    }
    
    func test_getAllCorrectWordList() {
        let expectedElements: UInt = 296
        let elements = accurateRepository.getWordList(
            expectedElementCount: expectedElements,
            correctWordPairRatio: 1.0
        )
        
        XCTAssertTrue(elements.allSatisfy({ $0.isCorrect == true }))
    }
    
    func test_getAllIncorrectWordList() {
        let expectedElements: UInt = 296
        let elements = accurateRepository.getWordList(
            expectedElementCount: expectedElements,
            correctWordPairRatio: 0.0
        )
        
        XCTAssertTrue(elements.allSatisfy({ $0.isCorrect == false }))
    }
    
    func test_getHalfCorrectHalfIncorrentWordList() {
        let expectedElements: UInt = 200
        let elements = accurateRepository.getWordList(
            expectedElementCount: expectedElements,
            correctWordPairRatio: 0.50
        )
        
        XCTAssertEqual(elements.filter({ $0.isCorrect == true }).count, 100)
        XCTAssertEqual(elements.filter({ $0.isCorrect == false }).count, 100)
    }
}
