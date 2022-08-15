//
//  BoundTableViewController.swift
//  WordGame
//
//  Created by Haider Ali Kazal on 13/8/22.
//

import UIKit

class BoundTableViewController<ViewModel>:
    BaseTableViewController,
    ViewModelBased {
    
    let viewModel: ViewModel
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Use .init(with:) instead")
    }
    
    private override init(
        nibName nibNameOrNil: String?,
        bundle nibBundleOrNil: Bundle?
    ) {
        fatalError("Use .init(with:) instead")
    }
    
    init(with viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
}

