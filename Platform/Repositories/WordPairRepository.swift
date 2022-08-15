//
//  WordPairRepository.swift
//  Platform
//
//  Created by Haider Ali Kazal on 10/8/22.
//

import Domain

protocol WordPairRepositoryProtocol {
    var fileURL: URL { get }
    
    init(fromFileURL: URL)
    
    func getWordList(
        expectedElementCount: UInt,
        correctWordPairRatio: Double
    ) -> [ResultedWordPair]
}

final class WordPairRepository: WordPairRepositoryProtocol {
    let fileURL: URL
    private var isFileRead: Bool = false
    
    private lazy var wordList: [WordPair]! = nil
    
    init(fromFileURL fileURL: URL) {
        self.fileURL = fileURL
    }
    
    func loadFromFile() throws {
        guard !isFileRead else { return }
        
        let data = try Data(contentsOf: fileURL)
        let decoder = JSONDecoder()
        wordList = try decoder.decode([WordPair].self, from: data)
        isFileRead = true
    }
    
    func getWordList(
        expectedElementCount: UInt,
        correctWordPairRatio: Double
    ) -> [ResultedWordPair] {
        do {
            try loadFromFile()
        } catch {
            fatalError(
                "Could not load json, error: \(error.localizedDescription)"
            )
        }
        
        let elements = pickCountedElements(expectedElementCount)
        let numberOfCorrectElements = Int(
            calculateCorrectWordPairElementCount(
                totalCount: expectedElementCount,
                correctWordPairRatio: correctWordPairRatio
            )
        )
        
        if numberOfCorrectElements == 0 {
            // Return all wrong elements
            
            let wrongPairs = makeWrongPairs(from: Array(elements))
            return wrongPairs.shuffled()
        } else if numberOfCorrectElements == expectedElementCount {
            // If numberOfCorrectElements is equal to expectedElementCount,
            // that means ratio is near or equal to 1.
            // So just return correct elements
            
            let correctPairs: [ResultedWordPair] = elements
                .map({ .init(wordPair: $0, isCorrect: true) })
            return correctPairs.shuffled()
        } else {
            // Mixed results
            
            let correctPairRange = 0...(numberOfCorrectElements - 1)
            let correctPairs: [ResultedWordPair] = elements[correctPairRange]
                .map({ .init(wordPair: $0, isCorrect: true) })
            
            let wrongPairRange = numberOfCorrectElements...(elements.count - 1)
            let wrongPairs = makeWrongPairs(
                from: Array(elements[wrongPairRange])
            )
            
            let totalPairs = (correctPairs + wrongPairs).shuffled()
            return totalPairs
        }
    }
    
    func calculateCorrectWordPairElementCount(
        totalCount: UInt,
        correctWordPairRatio: Double
    ) -> UInt {
        let countRounded = (Double(totalCount) * correctWordPairRatio).rounded()
        return UInt(countRounded)
    }
    
    func generateRandomIndexes(
        numberOfIndexes: UInt,
        fromRange range: ClosedRange<Int>
    ) -> [Int] {
        var randomizedTotalIndexes: [Int] = []
        
        while randomizedTotalIndexes.count <= range.count {
            let shuffledIndexes = Array(range).shuffled()
            randomizedTotalIndexes.append(contentsOf: shuffledIndexes)
        }
        
        let randomizedIndexes = randomizedTotalIndexes[
            0...(Int(numberOfIndexes) - 1)
        ]
        assert(randomizedIndexes.count == numberOfIndexes)
        return Array(randomizedIndexes)
    }
    
    func makeWrongPairs(
        from correctPairs: [WordPair]
    ) -> [ResultedWordPair] {
        var randomizedIndexes = Array(0...(correctPairs.count - 1))
            .shuffled()
        
        var isAllShuffled = false
        
        while isAllShuffled != true {
            let range = (correctPairs.count - 1)
            isAllShuffled = zip(Array(0...range), randomizedIndexes)
                .allSatisfy({ $0.0  != $0.1 })
            
            if !isAllShuffled {
                randomizedIndexes.shuffle()
            }
        }
        
        let indexes = zip(
            Array(0...(correctPairs.count - 1)),
            randomizedIndexes
        )
        
        let wrongPairs: [ResultedWordPair] = indexes.map({
            let wrongPair = WordPair(
                englishWord: correctPairs[$0].englishWord,
                spanishWord: correctPairs[$1].spanishWord
            )
            return .init(wordPair: wrongPair, isCorrect: false)
        })
        
        return wrongPairs
    }
    
    private func pickCountedElements(_ count: UInt) -> [WordPair] {
        if count > wordList.count {
            let countRangeUpperBound = Int(count - 1)
            let randomIndexes = generateRandomIndexes(
                numberOfIndexes: count,
                fromRange: 0...countRangeUpperBound
            )
            
            let wordListCountUpperBound = wordList.count - 1
            
            let wordPairs = randomIndexes.map({
                $0 > wordListCountUpperBound ? ($0 % wordListCountUpperBound) : $0
            }).map({
                wordList[$0]
            })
            
            return wordPairs
        } else {
            let wordListCountRangeUpperBound = wordList.count - 1
            let randomIndexes = generateRandomIndexes(
                numberOfIndexes: count,
                fromRange: 0...wordListCountRangeUpperBound
            )
            
            let wordPairs = randomIndexes.map({ wordList[$0] })
            return wordPairs
        }
    }
}
