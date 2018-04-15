//
//  UITableView+GithubSearchExtensions.swift
//  GithubSearch
//
//  Created by Anton Kozlovskyi on 4/16/18.
//  Copyright © 2018 Anton. All rights reserved.
//

import UIKit

extension UITableView {
    func dequeue<T>(_ cell: T.Type) -> T where T: UITableViewCell {
        let identifier = String(describing: cell)
        
        var object = self.dequeueReusableCell(withIdentifier: identifier)
        if object == nil {
            self.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
            object = UINib.load(class: cell)
        }
        
        return object as! T
    }
}
