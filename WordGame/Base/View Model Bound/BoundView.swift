//
//  BoundView.swift
//  WordGame
//
//  Created by Haider Ali Kazal on 13/8/22.
//

import UIKit

class BoundView<ViewModel>: BaseView, ViewModelBased {
    var viewModel: ViewModel
    
    required init?(coder: NSCoder) {
        fatalError("Use .init(with:) instead")
    }
    
    private override init(frame: CGRect) {
        fatalError("Use .init(with:) instead")
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }
    
    init(with viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
    }
}
