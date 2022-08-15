//
//  AppCoordinator.swift
//  WordGame
//
//  Created by Haider Ali Kazal on 13/8/22.
//

import UIKit

final class AppCoordinator: Coordinator {
    private(set) lazy var childCoordinators: [Coordinator] = []
    
    /*
    private let navigationController: BaseNavigationController = {
        let navigationController = BaseNavigationController()
        return navigationController
    }()
    */
    
    private weak var window: UIWindow?
    
    init(with window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        if !childCoordinators.isEmpty {
            childCoordinators.removeAll()
        }
        
        let childCoordinator = GameSceneCoordinator(containedIn: window)
        childCoordinators.append(childCoordinator)
        childCoordinators.forEach({ $0.start() })
    }
}
