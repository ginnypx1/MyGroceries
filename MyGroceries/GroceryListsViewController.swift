//
//  GroceryListsViewController.swift
//  MyGroceries
//
//  Created by Ginny Pennekamp on 4/17/17.
//  Copyright © 2017 GhostBirdGames. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class GroceryListsViewController: CoreDataTableViewController {
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the title
        title = "My Grocery Lists"
        
        // Get the stack
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let stack = delegate.stack
        
        // Create a fetchrequest
        let fr = NSFetchRequest<NSFetchRequestResult>(entityName: "GroceryList")
        fr.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true),
                              NSSortDescriptor(key: "creationDate", ascending: false)]
        
        // Create the FetchedResultsController
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fr, managedObjectContext: stack.context, sectionNameKeyPath: nil, cacheName: nil)
    }
    
    // MARK: - Add new grocery list
    
    @IBAction func addNewGroceryList(_ sender: Any) {
        // Create a new grocery list... and Core Data takes care of the rest!
        let gl = GroceryList(name: "New List", context: fetchedResultsController!.managedObjectContext)
        print("Just created a grocery list: \(gl)")
    }
    
    // MARK: TableView Data Source
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Find the right grocery list for this indexpath
        let gl = fetchedResultsController!.object(at: indexPath) as! GroceryList
        
        // Create the cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroceryListCell", for: indexPath)
        
        // Sync notebook -> cell
        cell.textLabel?.text = gl.name
        cell.detailTextLabel?.text = String(format: "%d items", gl.items!.count)
        
        return cell
    }
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier! == "displayItems" {
            
            if let itemsVC = segue.destination as? ItemsViewController {
                
                // Create Fetch Request
                let fr = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
                
                fr.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
                
                // So far we have a search that will match ALL notes. However, we're
                // only interested in those within the current grocery list:
                // NSPredicate to the rescue!
                let indexPath = tableView.indexPathForSelectedRow!
                let groceryList = fetchedResultsController?.object(at: indexPath)
                
                let pred = NSPredicate(format: "groceryList = %@", argumentArray: [groceryList!])
                
                fr.predicate = pred
                
                // Create FetchedResultsController
                let fc = NSFetchedResultsController(fetchRequest: fr, managedObjectContext:fetchedResultsController!.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
                
                // Inject it into the notesVC
                itemsVC.fetchedResultsController = fc
            }
        }
    }
    
}
