//
//  BaseTableViewCell.swift
//  WordGame
//
//  Created by Haider Ali Kazal on 13/8/22.
//

import UIKit

class BaseTableViewCell: UITableViewCell, ViewFlow {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupLayouts()
        assignLocalizedTexts()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        //selectionStyle = .none
    }
    
    func setupLayouts() { }
    
    func assignLocalizedTexts() { }
}
