//
//  ViewController.swift
//  Todoey
//
//  Created by Ruchir Vallabh on 12/09/18.
//  Copyright © 2018 Ruchir Vallabh. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    
    var itemArray = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    //Creating path there we'll create new plist now
  
    
    //let defaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
       // let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        //gets filepath of document directory where user information is stored
          // print(dataFilePath)
       
        
//        let newItem = Item()
//        newItem.title = "Find mike"
//        itemArray.append(newItem)
//
//        let newItem2 = Item()
//        newItem2.title = "Find mike"
//        itemArray.append(newItem2)
//
//        let newItem3 = Item()
//        newItem3.title = "Find mike"
//        itemArray.append(newItem3)
       
        
        
        
        
        
        
         loadItems()
        
//        if let items = defaults.array(forKey: "TodoListArray") as? [Item]//8
//        {
//        itemArray = items
//        }
//
        
    }
    
    
    
    
    //Mark: - 2 tableview datasource methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
      
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
     
        cell.accessoryType = item.done ? .checkmark : .none // Ternary Operator
        
        return cell
    }

    
  
     //Mark: - 3 Table View Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
        
        //tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
        
       }
    
    
    
    //Mark: - 4 add BarButton to add New Items
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
         var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            print("new Todoey Item Added")
            
            
            let  newItem = Item()
            newItem.title = textField.text!
        
            self.itemArray.append(newItem)
       
            self.saveItems()
           
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create item"
            textField = alertTextField
            
            print(alertTextField.text ?? "see addTextField closure")
                           }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    
    //Mark: Model Manipulation Methods
    
    
          //MARK: Encode Items to plist
    func saveItems() {
        let encoder = PropertyListEncoder()//change
        
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
            //Items.plist is created when first item is written, added
        }
        catch{
            print("Error encoding itemArray, \(error)")
        }
        
        tableView.reloadData()
    }
    
           //MARK:   Data Load
    
    
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do{
          try  itemArray = decoder.decode([Item].self, from: data)
               } catch {
                print("error while data load \(error)")
                   }
               }
        
           }
    
    
}

