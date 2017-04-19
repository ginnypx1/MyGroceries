//
//  Item+CoreDataClass.swift
//  MyGroceries
//
//  Created by Ginny Pennekamp on 4/17/17.
//  Copyright © 2017 GhostBirdGames. All rights reserved.
//

import Foundation
import CoreData

@objc(Item)
public class Item: NSManagedObject {
    
    convenience init(name: String = "New Item", context: NSManagedObjectContext) {
        
        if let ent = NSEntityDescription.entity(forEntityName: "Item", in: context) {
            self.init(entity: ent, insertInto: context)
            self.name = name
        } else {
            fatalError("Unable to find Entity name!")
        }
    }
}
