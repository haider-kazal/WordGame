//
//  BoundViewController.swift
//  WordGame
//
//  Created by Haider Ali Kazal on 13/8/22.
//

import UIKit

class BoundViewController<View: UIView, ViewModel>:
    BaseViewController,
    ViewBased,
    ViewModelBased {
    
    let rootView: View
    let viewModel: ViewModel
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Use .init(with:and:) instead")
    }
    
    private override init(
        nibName nibNameOrNil: String?,
        bundle nibBundleOrNil: Bundle?
    ) {
        fatalError("Use .init(with:and:) instead")
    }
    
    init(with view: View, and viewModel: ViewModel) {
        rootView = view
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        view = rootView
    }
}
