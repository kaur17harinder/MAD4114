//
//  User+CoreDataProperties.swift
//  CoreData01
//
//  Created by MacStudent on 2018-07-10.
//  Copyright © 2018 MacStudent. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var name: String?
    @NSManaged public var email: String?
    @NSManaged public var kids: Int16
    @NSManaged public var birthday: NSDate?

}
