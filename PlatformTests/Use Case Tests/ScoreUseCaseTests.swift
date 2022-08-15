//
//  ScoreUseCaseTests.swift
//  PlatformTests
//
//  Created by Haider Ali Kazal on 13/8/22.
//

import XCTest
@testable import Platform

class ScoreUseCaseTests: XCTestCase {
    private var scoreUseCase: ScoreUseCase!

    override func setUpWithError() throws {
        scoreUseCase = .init()
    }

    override func tearDownWithError() throws {
        scoreUseCase = nil
    }
    
    func test_correctAttemptProperlyIncreasesByOne() {
        // Arrange
        scoreUseCase.reset()
        
        // Act
        scoreUseCase.incrementCorrectAttempt(by: 1)
        let expectedCorrectAttempt = 1
        
        // Assert
        XCTAssertTrue(
            scoreUseCase.correctAttempt == expectedCorrectAttempt,
            "Correct attempy accurately increased by 1"
        )
    }
    
    func test_wrongAttemptProperlyIncreasesByOne() {
        // Arrange
        scoreUseCase.reset()
        
        // Act
        scoreUseCase.incrementWrongAttempt(by: 1)
        let expectedWrongAttempt = 1
        
        // Assert
        XCTAssertTrue(
            scoreUseCase.wrongAttempt == expectedWrongAttempt,
            "Wrong attempt accurately increased by 1"
        )
    }
    
    func test_resetWorksProperly() {
        // Arrange
        // Nothing to arrange
        
        // Act
        scoreUseCase.reset()
        let expectedCorrectAttempt = 0
        let expectedWrongAttempt = 0
        
        XCTAssertTrue(
            scoreUseCase.correctAttempt == expectedCorrectAttempt,
            "Correct attempt reset successful"
        )
        
        XCTAssertTrue(
            scoreUseCase.wrongAttempt == expectedWrongAttempt,
            "Wrong attempt reset successful"
        )
    }
}
