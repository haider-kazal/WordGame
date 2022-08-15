//
//  GameConfiguration.swift
//  WordGame
//
//  Created by Haider Ali Kazal on 13/8/22.
//

import Foundation

struct GameConfiguration {
    let timeToAnswerQuestion: TimeInterval
    let maxIncorrectAttempt: UInt
    let totalQuestion: UInt
    let correctQuestionProbability: Double
    
    init(
        timeToAnswerQuestion: TimeInterval,
        maxIncorrectAttempt: UInt,
        totalQuestion: UInt,
        correctQuestionProbability: Double
    ) {
        precondition(
            maxIncorrectAttempt < totalQuestion,
            "Max Incorrect Attempt cannot be greater than total question"
        )
        
        precondition(
            correctQuestionProbability >= 0.0 && correctQuestionProbability <= 1.0,
            "Correct Question Probability need to be between 0.0 to 1.0"
        )
        
        self.timeToAnswerQuestion = timeToAnswerQuestion
        self.maxIncorrectAttempt = maxIncorrectAttempt
        self.totalQuestion = totalQuestion
        self.correctQuestionProbability = correctQuestionProbability
    }
}
