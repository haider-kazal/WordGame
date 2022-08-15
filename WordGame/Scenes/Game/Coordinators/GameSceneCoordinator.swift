//
//  GameSceneCoordinator.swift
//  WordGame
//
//  Created by Haider Ali Kazal on 13/8/22.
//

import UIKit
import Platform

final class GameSceneCoordinator: Coordinator {
    private let useCaseProvider = UseCaseProvider()
    private let gameConfiguration = GameConfiguration(
        timeToAnswerQuestion: 5,
        maxIncorrectAttempt: 3,
        totalQuestion: 15,
        correctQuestionProbability: 0.25
    )
    
    private(set) lazy var childCoordinators: [Coordinator] = []
    
    private weak var window: UIWindow?
    
    init(containedIn window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        let viewModel = GameViewModel(
            with: gameConfiguration,
            scoreUseCase: useCaseProvider.scoreUseCase(),
            wordListUseCase: useCaseProvider
                .wordListUseCase(fileURL: Constants.URLs.wordsFileURL)
        )
        
        let view = GameView(with: viewModel)
        let viewController = GameViewController(with: view, and: viewModel)
        viewController.coordinator = self
        
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }
    
    func showGameEndAlert(scoreText: String) {
        let alert = Alert.Builder(ofStyle: .alert)
            .withTitle(Strings.Game.score.localized)
            .withMessage(scoreText)
            .withAction(
                title: Strings.Game.restart.localized,
                style: .default,
                onPress: { [weak self] _ in
                    self?.start()
                })
            .withAction(
                title: Strings.Game.quit.localized,
                style: .default,
                onPress: { [weak self] _ in
                    self?.closeApp()
                })
            .build()
        
        let alertCoordinator = AlertCoordinator(with: alert)
        childCoordinators.append(alertCoordinator)
        childCoordinators.first(where: { $0 === alertCoordinator })?.start()
    }
    
    private func closeApp() {
        UIControl().sendAction(
            #selector(URLSessionTask.suspend),
            to: UIApplication.shared,
            for: nil
        )
        
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { (timer) in
            exit(0)
        }
    }
}
