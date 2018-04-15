//
//  CoreDataManager.swift
//  GithubSearch
//
//  Created by Anton Kozlovskyi on 4/15/18.
//  Copyright © 2018 Anton. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    
    //MARK: -
    //MARK: Initialization
    
    static let shared = CoreDataManager()
    private init() {}
    
    //MARK: -
    //MARK: Accessors
    
    lazy var persistentContainer:NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreData")
        container.loadPersistentStores(completionHandler: { [weak self](storeDescription, error) in
            if let error = error {
                print("Core data error")
            }
        })
        
        return container
    }()
    
    lazy var viewContext:NSManagedObjectContext = {
        let viewContext = self.persistentContainer.viewContext
        viewContext.automaticallyMergesChangesFromParent = true
        
        return viewContext
    }()
    
    lazy var backgroundContext:NSManagedObjectContext = {
        return self.persistentContainer.newBackgroundContext()
    }()
    
    //MARK: -
    //MARK: Public
    
    func performForegroundTask(_ handler: @escaping (NSManagedObjectContext) -> ()) {
        self.viewContext.perform {
            handler(self.viewContext)
        }
    }
    
    func performBackgroundTask(_ handler: @escaping (NSManagedObjectContext) -> ()) {
        self.persistentContainer.performBackgroundTask(handler)
    }
}
