//
//  RootViewGettable.swift
//  GithubSearch
//
//  Created by Anton Kozlovskyi on 4/15/18.
//  Copyright © 2018 Anton. All rights reserved.
//

import UIKit

protocol RootViewGettable {
    associatedtype RootViewType: UIView
    var rootView: RootViewType? { get }
}

extension RootViewGettable where Self : UIViewController {
    
    var rootView: RootViewType? {
        return self.viewIfLoaded as? RootViewType
    }
}
