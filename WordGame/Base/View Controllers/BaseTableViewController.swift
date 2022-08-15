//
//  BaseTableViewController.swift
//  WordGame
//
//  Created by Haider Ali Kazal on 13/8/22.
//

import UIKit

class BaseTableViewController: UITableViewController, BaseController {
    override var preferredStatusBarStyle: UIStatusBarStyle { .default }
    
    deinit { `deinit`() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        didLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        willAppear()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        didAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        willDisappear()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        didDisappear()
    }
    
    func setupViews() {
        
    }
    
    func setupLayouts() {
        
    }
    
    func assignLocalizedTexts() {
        //updateBackButton()
    }
    
    private func updateBackButton() {
        navigationItem.backButtonTitle = Strings.Common.back.localized
    }
}
