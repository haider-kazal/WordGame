//
//  UseCaseProviderTest.swift
//  PlatformTests
//
//  Created by Haider Ali Kazal on 14/8/22.
//

import XCTest
@testable import Platform

class UseCaseProviderTests: XCTestCase {
    var useCaseProvider: UseCaseProvider!
    
    override func setUpWithError() throws {
        useCaseProvider = .init()
    }

    override func tearDownWithError() throws {
        useCaseProvider = nil
    }
    
    func test_getsScoreUseCase() {
        XCTAssertNotNil(
            useCaseProvider.scoreUseCase(),
            "Properly received score use case"
        )
    }
    
    func test_getsWordListUseCase() {
        let fileURL = Bundle.main
            .url(forResource: "words", withExtension: "json")!
        
        XCTAssertNotNil(
            useCaseProvider.wordListUseCase(fileURL: fileURL),
            "Properly received word list use case"
        )
    }
}
