//
//  ItemsViewController.swift
//  MyGroceries
//
//  Created by Ginny Pennekamp on 4/19/17.
//  Copyright © 2017 GhostBirdGames. All rights reserved.
//

import UIKit

class ItemsViewController: CoreDataTableViewController {
    
    // MARK: Properties
    
    var groceryList: GroceryList?
    
    // MARK: - View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add "Add to List" bar button item
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add to List", style: .plain, target: self, action: #selector(addItemToDatabase))
        
        // Set the title
        guard let glist = groceryList else {
            print("There is no recognized grocery list")
            return
        }
        title = "\(String(describing: glist.name)))"

    }
    
    // MARK: - Add new item to the list
    
    func addItemToDatabase() {
        if let gl = groceryList, let context = fetchedResultsController?.managedObjectContext {
            let newItem = Item(name: "New Item", context: context)
            newItem.groceryList = gl
            print("Created new item: \(String(describing: newItem))")
        } else {
            print("There was a problem adding an item")
        }
    }
    
    func addNewItemInAlert() {
        let alert = UIAlertController(title: "Add an Item",
                                      message: "Please enter the name of the item.",
                                      preferredStyle: .alert)
        
        // Submit button
        let submitAction = UIAlertAction(title: "Submit", style: .default, handler: { (action) -> Void in
            // Get 1st TextField's text
            let textField = alert.textFields![0]
            if let listItem = textField.text {
                self.addItemToDatabase()
            }
        })
        
        // Cancel button
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) -> Void in })
        
        // Add 1 textField and customize it
        alert.addTextField { (textField: UITextField) in
            textField.keyboardAppearance = .dark
            textField.keyboardType = .default
            textField.autocorrectionType = .default
            textField.placeholder = "Bananas"
            textField.clearButtonMode = .whileEditing
        }
        
        // Add action buttons and present the Alert
        alert.addAction(submitAction)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: TableView Data Source
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Get the note
        let item = fetchedResultsController?.object(at: indexPath) as! Item
        
        // Get the cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        
        // Sync note -> cell
        cell.textLabel?.text = item.name
        
        // Return the cell
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if let context = fetchedResultsController?.managedObjectContext, let item = fetchedResultsController?.object(at: indexPath) as? Item, editingStyle == .delete {
            context.delete(item)
        }
    }
    
}
