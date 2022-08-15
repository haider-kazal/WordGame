//
//  ViewModelBasedCell.swift
//  WordGame
//
//  Created by Haider Ali Kazal on 13/8/22.
//

protocol ViewModelBasedCell {
    associatedtype ViewModel
    func configureWith(viewModel: ViewModel)
}
