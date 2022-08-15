//
//  UIApplication+Extension.swift
//  WordGame
//
//  Created by Haider Ali Kazal on 13/8/22.
//

import UIKit

extension UIApplication {
    var mainWindow: UIWindow? {
        if #available(iOS 13.0, *) {
            return connectedScenes
                .filter({ $0.activationState == .foregroundActive })
                .map({ $0 as? UIWindowScene })
                .compactMap({ $0 })
                .first?.windows
                .filter({ $0.isKeyWindow })
                .first
        } else {
            return keyWindow
        }
    }
    
    var topMostViewController: UIViewController? {
        getTopViewController(basedOn: mainWindow?.rootViewController)
    }
    
    private func getTopViewController(
        basedOn viewController: UIViewController?
    ) -> UIViewController? {
        if let navigationController = viewController as? UINavigationController {
            return getTopViewController(
                basedOn: navigationController.visibleViewController
            )
        } else if let tabBarController = viewController as? UITabBarController,
                  let selectedViewController =
                    tabBarController.selectedViewController {
            return getTopViewController(basedOn: selectedViewController)
        } else if let presentedViewController =
                    viewController?.presentedViewController {
            return getTopViewController(basedOn: presentedViewController)
        } else {
            return viewController
        }
    }
}
