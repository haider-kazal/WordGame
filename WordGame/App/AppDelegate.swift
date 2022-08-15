//
//  AppDelegate.swift
//  WordGame
//
//  Created by Haider Ali Kazal on 10/8/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    private(set) var appCoordinator: AppCoordinator?
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if #available(iOS 13.0, *) {
            return true
        } else {
            window = UIWindow()
            appCoordinator = .init(with: window)
            appCoordinator?.start()
            return true
        }
    }
}

// MARK: UISceneSession Lifecycle
@available(iOS 13.0, *)
extension AppDelegate {
    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(
        _ application: UIApplication,
        didDiscardSceneSessions sceneSessions: Set<UISceneSession>
    ) {
        
    }
}

