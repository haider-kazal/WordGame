//
//  UseCaseProvider.swift
//  Platform
//
//  Created by Haider Ali Kazal on 10/8/22.
//

import Domain

public final class UseCaseProvider: Domain.UseCaseProvider {
    public init() {
        
    }
    
    public func wordListUseCase(fileURL: URL) -> Domain.WordListUseCase {
        let repository = makeWordPairRepository(using: fileURL)
        let wordListUseCase = Platform.WordListUseCase(repository: repository)
        return wordListUseCase
    }
    
    public func scoreUseCase() -> Domain.ScoreUseCase {
        return Platform.ScoreUseCase()
    }
    
    private func makeWordPairRepository(using url: URL) -> WordPairRepository {
        return .init(fromFileURL: url)
    }
}
