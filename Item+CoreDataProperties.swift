//
//  Item+CoreDataProperties.swift
//  MyGroceries
//
//  Created by Ginny Pennekamp on 4/17/17.
//  Copyright © 2017 GhostBirdGames. All rights reserved.
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var name: String?
    @NSManaged public var groceryList: GroceryList?

}
