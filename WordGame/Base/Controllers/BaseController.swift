//
//  BaseController.swift
//  WordGame
//
//  Created by Haider Ali Kazal on 13/8/22.
//

import UIKit

protocol BaseController: ViewFlow {
    func `deinit`()
    
    func didLoad()
    
    func willAppear()
    func didAppear()
    
    func willDisappear()
    func didDisappear()
}

extension BaseController where Self: UIViewController {
    func `deinit`() {
        NotificationCenter.default.removeObserver(self)
    }
    
    func didLoad() {
        setNeedsStatusBarAppearanceUpdate()
        updateRootViewBackgroundColor()
        assignLocalizedTexts()
        
        setupViews()
        setupLayouts()
        setupLocalizationObservers()
    }
    
    func willAppear() {
        //navigationController?.setNavigationBarColor(UIColor(named: "AppYellow")!)
        //navigationController?.navigationBar.tintColor = .black
    }
    
    func didAppear() { }
    
    func willDisappear() { }
    
    func didDisappear() { }
    
    private func updateRootViewBackgroundColor() {
        //view.backgroundColor = .black
        if #available(iOS 13.0, *) {
            view.backgroundColor = UIColor.systemBackground
        }
        
        
        
    }
}
