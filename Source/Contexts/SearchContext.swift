//
//  SearchContext.swift
//  GithubSearch
//
//  Created by Anton Kozlovskyi on 4/15/18.
//  Copyright © 2018 Anton. All rights reserved.
//

import Foundation

fileprivate struct Keys {
    static let downloadURL = "https://api.github.com/search/repositories?q=%@&sort=stars&page=%d&per_page=15"
    static let pagesCount = 2
    
    static let items = "items"
    static let id = "id"
    static let name = "name"
    static let stars = "stargazers_count"
}

class SearchContext {
    private var urlSession: URLSession = URLSession(configuration: .default)
    private var searchWord: String
    
    //MARK: -
    //MARK: Initialization
    
    convenience init() {
        self.init("topic")
    }
    
    init(_ searchWord: String) {
        self.searchWord = searchWord
    }
    
    //MARK: -
    //MARK: Public
    
    func load() {
        self.cancel()
        SearchRepository.deleteAll()
        
        for i in 1...Keys.pagesCount {
            let URLString = String(format: Keys.downloadURL, self.searchWord, i)
            if let url = URL(string: URLString) {
                self.urlSession.load(url, completionHandler: {[weak self] data, response, error in
                    guard let data = data else {
                        return
                    }
                    if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] {
                        let items = json?[Keys.items] as? [[String : Any]]
                        self?.parse(items)
                    }
                })
            }
        }
    }
    
    func cancel() {
        self.urlSession.cancelAllTasks()
    }

    //MARK: -
    //MARK: Privates
    
    private func parse(_ items: [[String : Any]]?) {
        guard let items = items else {
            return
        }
        
        CoreDataManager.shared.performBackgroundTask { backgroundContext in
            items.forEach {
                let repository = SearchRepository(context: backgroundContext)
                repository.name = $0[Keys.name] as? String
                repository.id = $0[Keys.id] as? String
                repository.stars = $0[Keys.stars] as? Int64 ?? 0
            }

            backgroundContext.saveContext()
        }
    }
    
}
