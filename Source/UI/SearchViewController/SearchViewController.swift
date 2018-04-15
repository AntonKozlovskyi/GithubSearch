//
//  SearchViewController.swift
//  GithubSearch
//
//  Created by Anton Kozlovskyi on 4/15/18.
//  Copyright © 2018 Anton. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, RootViewGettable {
    typealias RootViewType = SearchView
    
    var context: SearchContext? {
        didSet {
            context?.load()
        }
    }
    
//MARK: -
//MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.context = SearchContext()
    }

}

//MARK: -
//MARK: UITableView delegate

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

//MARK: -
//MARK: UITableView dataSource

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
