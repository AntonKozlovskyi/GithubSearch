//
//  SearchRepository+CoreDataProperties.swift
//  GithubSearch
//
//  Created by Anton Kozlovskyi on 4/15/18.
//  Copyright © 2018 Anton. All rights reserved.
//
//

import Foundation
import CoreData

extension SearchRepository {
    public class func fetchRequest() -> NSFetchRequest<SearchRepository> {
        return NSFetchRequest<SearchRepository>(entityName: "SearchRepository")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var stars: Int64
    @NSManaged public var url: String?

}
