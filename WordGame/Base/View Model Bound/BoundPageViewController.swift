//
//  BoundPageViewController.swift
//  WordGame
//
//  Created by Haider Ali Kazal on 13/8/22.
//

import UIKit

class BoundPageViewController<ViewModel>:
    BasePageViewController,
    ViewModelBased {
    
    let viewModel: ViewModel
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Use .init(with:) instead")
    }
    
    init(nibName: String?, bundle: Bundle?) {
        fatalError("Use .init(with:) instead")
    }
    
    override init(
        transitionStyle style: UIPageViewController.TransitionStyle,
        navigationOrientation: UIPageViewController.NavigationOrientation,
        options: [UIPageViewController.OptionsKey: Any]? = nil
    ) {
        fatalError("Use .init(with:) instead")
    }
    
    init(
        with viewModel: ViewModel,
        transitionStyle style: UIPageViewController.TransitionStyle,
        navigationOrientation: UIPageViewController.NavigationOrientation,
        options: [UIPageViewController.OptionsKey: Any]? = nil
    ) {
        self.viewModel = viewModel
        super.init(
            transitionStyle: style,
            navigationOrientation: navigationOrientation,
            options: options
        )
    }
}
