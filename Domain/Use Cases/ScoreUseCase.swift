//
//  ScoreUseCase.swift
//  Domain
//
//  Created by Haider Ali Kazal on 10/8/22.
//

public protocol ScoreUseCase {
    var correctAttempt: UInt { get }
    var wrongAttempt: UInt { get }
    
    func incrementCorrectAttempt(by value: UInt)
    func incrementWrongAttempt(by value: UInt)
    
    func reset()
}
