//
//  ViewModelType.swift
//  WordGame
//
//  Created by Haider Ali Kazal on 13/8/22.
//

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
