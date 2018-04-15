//
//  UINib+GithubSearchExtensions.swift
//  GithubSearch
//
//  Created by Anton Kozlovskyi on 4/16/18.
//  Copyright © 2018 Anton. All rights reserved.
//

import UIKit

extension UINib {
    
    class func load<T>(class theClass: T.Type, bundle: Bundle? = Bundle.main, owner: Any? = nil) -> T? {
        let identifier = String(describing: theClass)
        
        let nib = UINib(nibName: identifier, bundle: bundle)
        let objects = nib.instantiate(withOwner: owner, options: nil)
        
        if objects.count == 0 {
            return nil
        }
        
        for case let object as AnyObject in objects {
            if type(of: object) == T.self {
                return (object as! T)
            }
        }
        
        return nil
    }
}
