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

protocol SearchDelegate: class {
    func cell(_ cell: SearchCell, didSelect model:SearchRepository)
}

class SearchCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var starsLabel: UILabel?

    weak var delegate: SearchDelegate?

    var model: SearchRepository? {
        didSet {
            if let model = model, let name = model.name {
                var string = name
                if string.count > Keys.maxTextLength {
                    string = String(string.prefix(Keys.maxTextLength))
                }
                
                self.titleLabel?.text = string
                self.starsLabel?.text = "stars: \(model.stars)"
            }
        }
    }

    //MARK: -
    //MARK: View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tapRecognizer = UITapGestureRecognizer(target: self,
                                                   action:#selector(onTouch(sender:)))
        self.titleLabel?.addGestureRecognizer(tapRecognizer)
    }
    
    //MARK: -
    //MARK: Private
    
    @objc private func onTouch(sender:UITapGestureRecognizer) {
        if let model = self.model {
            self.delegate?.cell(self, didSelect: model)
        }
    }
    
}
