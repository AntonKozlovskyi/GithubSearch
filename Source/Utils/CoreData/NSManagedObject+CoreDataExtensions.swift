//
//  NSManagedObject+CoreDataExtensions.swift
//  GithubSearch
//
//  Created by Anton Kozlovskyi on 4/15/18.
//  Copyright © 2018 Anton. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObject {
    
    //MARK: -
    //MARK: Accessors
    private class var entityName: String {
        let name = NSStringFromClass(self)
        return name.components(separatedBy: ".").last ?? ""
    }
    
    //MARK: -
    //MARK: Class Methods
    
    class func createFetchRequest<T: NSManagedObject>(predicate: NSPredicate? = nil,
                                                      sortDescriptors: [NSSortDescriptor]? = nil) -> NSFetchRequest<T> {
        
        let request = NSFetchRequest<T>(entityName: self.entityName)
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        
        return request
    }
    
    class func all<T: NSManagedObject>(with predicate: NSPredicate? = nil,
                                       orderedBy sortDescriptors: [NSSortDescriptor]? = nil,
                                       ascending: Bool = true) -> [T]
    {
        let request = self.createFetchRequest(predicate: predicate,
                                              sortDescriptors: sortDescriptors)
        let result = try? CoreDataManager.shared.viewContext.fetch(request)
        
        return result as? [T] ?? []
    }
    
    class func deleteAll() {
        let context = CoreDataManager.shared.viewContext
        let objects = self.all()
        for object in objects {
            context.delete(object)
        }
        
        context.saveContext()
    }
}
