//
//  UseCaseProvider.swift
//  Domain
//
//  Created by Haider Ali Kazal on 10/8/22.
//

import Foundation

public protocol UseCaseProvider: AnyObject {
    func wordListUseCase(fileURL: URL) -> WordListUseCase
    func scoreUseCase() -> ScoreUseCase
}
