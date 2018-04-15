//
//  URLSession+GithubSearchExtensions.swift
//  GithubSearch
//
//  Created by Anton Kozlovskyi on 4/15/18.
//  Copyright © 2018 Anton. All rights reserved.
//

import Foundation

extension URLSession {
    
    @discardableResult func load(_ url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> ()) -> URLSessionDataTask {
        let task = dataTask(with: url, completionHandler: completionHandler)
        task.resume()
        
        return task
    }
    
    func cancelAllTasks() {
        self.getAllTasks{ allTasks in
            allTasks.forEach{$0.cancel()}
        }
    }
}
