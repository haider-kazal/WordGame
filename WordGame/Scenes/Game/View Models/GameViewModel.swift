//
//  GameViewModel.swift
//  WordGame
//
//  Created by Haider Ali Kazal on 13/8/22.
//

import Combine
import Domain

final class GameViewModel {
    let gameConfiguration: GameConfiguration
    
    let scoreLabelTextSubject: CurrentValueSubject<String, Never>
    let currentWordPairSubject: PassthroughSubject<WordPair, Never>
    let isGameEndSubject: PassthroughSubject<Bool, Never>
    
    private let scoreUseCase: ScoreUseCase
    private let wordListUseCase: WordListUseCase

    private lazy var wordList: [ResultedWordPair] = []

    private var answeredQuestion: UInt = 0
    
    private var currentQuestion: ResultedWordPair! = nil {
        didSet {
            guard currentQuestion != nil else {
                return
            }
            
            currentWordPairSubject.send(currentQuestion.wordPair)
        }
    }
    
    var scoreLabelText: String {
        let correctAttemptsString = Strings.Game.correctAttempts.localized
            .replacingOccurrences(
                of: "__score__",
                with: String(scoreUseCase.correctAttempt)
            )
        
        let wrongAttemptsString = Strings.Game.wrongAttempts.localized
            .replacingOccurrences(
                of: "__score__",
                with: String(scoreUseCase.wrongAttempt)
            )
        
        return "\(correctAttemptsString)\n\(wrongAttemptsString)"
    }
    
    var isGameEnded: Bool {
        gameConfiguration.totalQuestion == answeredQuestion ||
        scoreUseCase.wrongAttempt == gameConfiguration.maxIncorrectAttempt
    }
    
    init(
        with gameConfiguration: GameConfiguration,
        scoreUseCase: ScoreUseCase,
        wordListUseCase: WordListUseCase
    ) {
        self.gameConfiguration = gameConfiguration
        self.scoreUseCase = scoreUseCase
        self.wordListUseCase = wordListUseCase
        
        scoreLabelTextSubject = .init("")
        currentWordPairSubject = .init()
        isGameEndSubject = .init()
    }
    
    func prepareWordListForThisRound() {
        wordList = wordListUseCase.getResultedWordList(
            numberOfElements: gameConfiguration.totalQuestion,
            correctWordPairRatio: gameConfiguration.correctQuestionProbability
        )
        
        currentQuestion = wordList[0]
    }
    
    func userAnsweredCorrect() {
        defer {
            increaseAnsweredQuestionByOne()
            sendScoreTextUpdate()
            sendGameEndUpdateIfGameEnded()
            sendNextQuestionIfGameNotEnded()
        }
        
        if currentQuestion.isCorrect {
            scoreUseCase.incrementCorrectAttempt(by: 1)
        } else {
            scoreUseCase.incrementWrongAttempt(by: 1)
        }
    }
    
    func userAnsweredWrong() {
        defer {
            increaseAnsweredQuestionByOne()
            sendScoreTextUpdate()
            sendGameEndUpdateIfGameEnded()
            sendNextQuestionIfGameNotEnded()
        }
        
        if currentQuestion.isCorrect {
            scoreUseCase.incrementWrongAttempt(by: 1)
        } else {
            scoreUseCase.incrementCorrectAttempt(by: 1)
        }
    }
    
    func questionTimedOut() {
        scoreUseCase.incrementWrongAttempt(by: 1)
        increaseAnsweredQuestionByOne()
        sendScoreTextUpdate()
        sendGameEndUpdateIfGameEnded()
        sendNextQuestionIfGameNotEnded()
    }
    
    func reset() {
        wordList = []
        scoreUseCase.reset()
        answeredQuestion = 0
        sendScoreTextUpdate()
    }
    
    private func increaseAnsweredQuestionByOne() {
        answeredQuestion += 1
    }
    
    private func sendScoreTextUpdate() {
        scoreLabelTextSubject.send(scoreLabelText)
    }
    
    private func sendGameEndUpdateIfGameEnded() {
        guard isGameEnded else { return }
        return isGameEndSubject.send(true)
    }
    
    private func sendNextQuestionIfGameNotEnded() {
        guard answeredQuestion < wordList.count && !isGameEnded else { return }
        currentQuestion = wordList[Int(answeredQuestion)]
    }
}
