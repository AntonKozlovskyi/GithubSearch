//
//  SearchCell.swift
//  GithubSearch
//
//  Created by Anton Kozlovskyi on 4/16/18.
//  Copyright © 2018 Anton. All rights reserved.
//

import UIKit

fileprivate struct Keys {
    static let maxTextLength = 30
}

class SearchCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel?
    
    //MARK: -
    //MARK: Public
    
    func fill(with model:SearchRepository) {
        if let name = model.name {
            var string = name
            if string.count > Keys.maxTextLength {
                string = String(string.prefix(Keys.maxTextLength))
            }
            
            self.titleLabel?.text = string
        }
    }
}
