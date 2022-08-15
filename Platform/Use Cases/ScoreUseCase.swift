//
//  ScoreUseCase.swift
//  Platform
//
//  Created by Haider Ali Kazal on 10/8/22.
//

import Domain

public final class ScoreUseCase: Domain.ScoreUseCase {
    private(set) public var correctAttempt: UInt
    private(set) public var wrongAttempt: UInt
    
    public init() {
        correctAttempt = 0
        wrongAttempt = 0
    }
    
    public func incrementCorrectAttempt(by value: UInt) {
        correctAttempt += value
    }
    
    public func incrementWrongAttempt(by value: UInt) {
        wrongAttempt += value
    }
    
    public func reset() {
        correctAttempt = 0
        wrongAttempt = 0
    }
}
