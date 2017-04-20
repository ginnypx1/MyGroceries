//
//  GroceryList+CoreDataClass.swift
//  MyGroceries
//
//  Created by Ginny Pennekamp on 4/20/17.
//  Copyright © 2017 GhostBirdGames. All rights reserved.
//

import Foundation
import CoreData


public class GroceryList: NSManagedObject {
    
    convenience init(name: String, context: NSManagedObjectContext) {
        
        if let ent = NSEntityDescription.entity(forEntityName: "GroceryList", in: context) {
            self.init(entity: ent, insertInto: context)
            self.name = name;
            self.creationDate = Date() as NSDate
        } else {
            fatalError("Unable to find Entity name!")
        }
    }
}
