//
//  NSManagedObjectContext+CoreDataExtensions.swift
//  GithubSearch
//
//  Created by Anton Kozlovskyi on 4/15/18.
//  Copyright © 2018 Anton. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObjectContext {
    
    //MARK: -
    //MARK: Public
    
    func saveContext() {
        if self.hasChanges {
            do {
                try save()
            } catch let error as NSError {
                print(error.description)
            }
        }
    }
}
