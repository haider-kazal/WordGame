//
//  AlertCoordinator.swift
//  WordGame
//
//  Created by Haider Ali Kazal on 13/8/22.
//

import UIKit

final class AlertCoordinator: Coordinator {
    let alert: Alert
    
    private(set) lazy var childCoordinators: [Coordinator] = []
    private(set) weak var viewController: UIViewController?
    
    var topViewController: UIViewController? {
        UIApplication.shared.topMostViewController
    }
    
    init(
        with alert: Alert,
        presentingFrom viewController: UIViewController? = nil
    ) {
        self.alert = alert
        self.viewController = viewController
    }
    
    func start() {
        guard viewController != nil else {
            topViewController?
                .present(alert.alertController, animated: true, completion: nil)
            return
        }
        
        viewController?
            .present(alert.alertController, animated: true, completion: nil)
    }
}

final class Alert {
    let alertController: UIAlertController
    
    private init(with alertController: UIAlertController) {
        self.alertController = alertController
        alertController.view.tintColor = .systemBlue
    }
}

extension Alert {
    class Builder {
        let style: UIAlertController.Style
        
        private(set) var title: String
        private(set) var message: String
        
        private var actions: [UIAlertAction] =  []
        private lazy var textFieldConfigurations: [((UITextField) -> Void)?] = []
        
        init(ofStyle style: UIAlertController.Style) {
            self.style = style
            title = ""
            message = ""
        }
        
        @discardableResult
        func withTitle(_ title: String) -> Builder {
            self.title = title
            return self
        }
        
        @discardableResult
        func withMessage(_ message: String) -> Builder {
            self.message = message
            return self
        }
        
        @discardableResult
        func withAction(
            title: String?,
            style: UIAlertAction.Style,
            onPress handler: ((UIAlertAction) -> Void)?
        ) -> Builder {
            let alertAction = UIAlertAction(
                title: title,
                style: style,
                handler: handler
            )
            actions.append(alertAction)
            return self
        }
        
        @discardableResult
        func withTextField(
            configurationHandler: ((UITextField) -> Void)?
        ) -> Builder {
            textFieldConfigurations.append(configurationHandler)
            return self
        }
        
        @discardableResult
        func withOKAction(
            onPress handler: ((UIAlertAction) -> Void)?
        ) -> Builder {
            let alertAction = UIAlertAction(
                title: Strings.Common.ok.localized,
                style: .default,
                handler: handler
            )
            actions.append(alertAction)
            return self
        }
        
        @discardableResult
        func withCancelAction(
            onPress handler: ((UIAlertAction) -> Void)?
        ) -> Builder {
            let alertAction = UIAlertAction(
                title: Strings.Common.cancel.localized,
                style: .cancel,
                handler: handler
            )
            actions.append(alertAction)
            return self
        }
        
        @discardableResult
        func withYesAction(
            onPress handler: ((UIAlertAction) -> Void)?
        ) -> Builder {
            let alertAction = UIAlertAction(
                title: Strings.Common.yes.localized,
                style: .default,
                handler: handler
            )
            actions.append(alertAction)
            return self
        }
        
        @discardableResult
        func withNoAction(
            onPress handler: ((UIAlertAction) -> Void)?
        ) -> Builder {
            let alertAction = UIAlertAction(
                title: Strings.Common.no.localized,
                style: .destructive,
                handler: handler
            )
            actions.append(alertAction)
            return self
        }
        
        func build() -> Alert {
            let alertController = UIAlertController(
                title: title,
                message: message,
                preferredStyle: style
            )
            actions.forEach({ alertController.addAction($0) })
            textFieldConfigurations.forEach({
                alertController.addTextField(configurationHandler: $0)
            })
            return .init(with: alertController)
        }
    }
}
