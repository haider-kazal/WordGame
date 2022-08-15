//
//  WordGameTests.swift
//  WordGameTests
//
//  Created by Haider Ali Kazal on 10/8/22.
//

import Combine
import Platform
import XCTest
@testable import WordGame

class GameViewModelTests: XCTestCase {
    private var cancellables: Set<AnyCancellable> = .init()
    var viewModel: GameViewModel!
    
    override func setUpWithError() throws {
        let gameConfiguration = GameConfiguration(
            timeToAnswerQuestion: 5,
            maxIncorrectAttempt: 3,
            totalQuestion: 15,
            correctQuestionProbability: 0.25
        )
        
        let fileURL = Bundle(for: type(of: self))
            .url(forResource: "words", withExtension: "json")!
        
        let useCaseProvider = UseCaseProvider()
        
        viewModel = .init(
            with: gameConfiguration,
            scoreUseCase: useCaseProvider.scoreUseCase(),
            wordListUseCase: useCaseProvider.wordListUseCase(fileURL: fileURL)
        )
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    func test_willGetAWordPairAfterPraparing() {
        let combineExpectation = expectation(
            description: "Will get a word pair"
        )
        
        viewModel.currentWordPairSubject
            .sink(receiveValue: { (wordPair) in
                combineExpectation.fulfill()
            })
            .store(in: &cancellables)
        
        viewModel.prepareWordListForThisRound()
        
        wait(for: [combineExpectation], timeout: 2)
    }
    
    func test_willGetEmptyScoreAfterPreparing() {
        let combineExpectation = expectation(
            description: "Will get a empty score"
        )
        
        viewModel.scoreLabelTextSubject
            .sink(receiveValue: { (scoreLabel) in
                combineExpectation.fulfill()
            })
            .store(in: &cancellables)
        
        viewModel.prepareWordListForThisRound()
        
        wait(for: [combineExpectation], timeout: 2)
    }
    
    func test_gameEndScenarioTest() {
        let combineExpectation = expectation(
            description: "Will get game end event"
        )
        
        viewModel.isGameEndSubject
            .sink(receiveValue: { (isGameEnded) in
                combineExpectation.fulfill()
            })
            .store(in: &cancellables)
        
        viewModel.prepareWordListForThisRound()
        
        viewModel.questionTimedOut()
        viewModel.questionTimedOut()
        viewModel.questionTimedOut()
        
        wait(for: [combineExpectation], timeout: 2)
    }
}
