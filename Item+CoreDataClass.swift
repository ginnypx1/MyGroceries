//
//  Item+CoreDataClass.swift
//  MyGroceries
//
//  Created by Ginny Pennekamp on 4/20/17.
//  Copyright © 2017 GhostBirdGames. All rights reserved.
//

import Foundation
import CoreData


public class Item: NSManagedObject {
    
    convenience init(name: String = "New Note", context: NSManagedObjectContext) {
        
        if let ent = NSEntityDescription.entity(forEntityName: "Item", in: context) {
            self.init(entity: ent, insertInto: context)
            self.name = name
        } else {
            fatalError("Unable to find Entity name!")
        }
    }
}
