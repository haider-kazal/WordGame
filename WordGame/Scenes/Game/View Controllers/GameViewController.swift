//
//  GameViewController.swift
//  WordGame
//
//  Created by Haider Ali Kazal on 13/8/22.
//

import Combine
import Domain
import UIKit

final class GameViewController: BoundViewController<GameView, GameViewModel> {
    private var cancellables: Set<AnyCancellable> = .init()
    private var isGameOngoing: Bool = true
    
    weak var coordinator: GameSceneCoordinator?
    
    override func setupViews() {
        super.setupViews()
        
        rootView.correctButton.addTarget(
            self,
            action: #selector(correctButtonPressed(sender:)),
            for: .touchUpInside
        )
        
        rootView.wrongButton.addTarget(
            self,
            action: #selector(wrongButtonPressed(sender:)),
            for: .touchUpInside
        )
        
        viewModel.isGameEndSubject
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] (isGameEnded) in
                guard isGameEnded else { return }
                self?.rootView.reset()
                
                guard let self = self else { return }
                self.coordinator?
                    .showGameEndAlert(scoreText: self.viewModel.scoreLabelText)
            })
            .store(in: &cancellables)
        
        viewModel.scoreLabelTextSubject
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] _ in
                self?.rootView.updateScoreLabel()
            })
            .store(in: &cancellables)
        
        viewModel.currentWordPairSubject
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] (wordPair) in
                self?.rootView.resetTopAnchorConstraint()
                self?.rootView.updateWordPairLabels(with: wordPair)
                
                DispatchQueue.main.asyncAfter(
                    deadline: .now() + .milliseconds(1),
                    execute: {
                        self?.rootView.startSpanishWordAnimation()
                    })
            })
            .store(in: &cancellables)
        
        NotificationCenter.default.addObserver(
            forName: UIApplication.didEnterBackgroundNotification,
            object: nil,
            queue: .main,
            using: { [weak self] _ in
                self?.viewModel.reset()
                self?.rootView.reset()
                self?.isGameOngoing = false
            })
        
        NotificationCenter.default.addObserver(
            forName: UIApplication.willEnterForegroundNotification,
            object: nil,
            queue: .main,
            using: {[weak self] _ in
                guard self?.isGameOngoing == false else { return }
                self?.viewModel.prepareWordListForThisRound()
            })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(
            deadline: .now() + .nanoseconds(1),
            execute: { [weak self] in
                self?.viewModel.prepareWordListForThisRound()
            })
    }
    
    @objc
    private func correctButtonPressed(sender: UIButton) {
        rootView.stopSpanishWordAnimation()
        rootView.reset()
        viewModel.userAnsweredCorrect()
    }
    
    @objc
    func wrongButtonPressed(sender: UIButton) {
        rootView.stopSpanishWordAnimation()
        rootView.reset()
        viewModel.userAnsweredWrong()
    }
}
