//
//  ViewModelBased.swift
//  WordGame
//
//  Created by Haider Ali Kazal on 13/8/22.
//

protocol ViewModelBased: AnyObject {
    associatedtype ViewModel
    var viewModel: ViewModel { get }
}
