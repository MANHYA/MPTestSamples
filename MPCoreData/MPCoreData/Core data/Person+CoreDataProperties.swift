//
//  Person+CoreDataProperties.swift
//  MPCoreData
//
//  Created by Manish on 4/16/19.
//  Copyright © 2019 MANHYA. All rights reserved.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var name: String?
    @NSManaged public var mobile: String?

}
