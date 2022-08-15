//
//  ViewBased.swift
//  WordGame
//
//  Created by Haider Ali Kazal on 13/8/22.
//

import UIKit

protocol ViewBased {
    associatedtype View: UIView
    var rootView: View { get }
}
