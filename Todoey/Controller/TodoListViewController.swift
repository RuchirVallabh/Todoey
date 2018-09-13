//
//  ViewController.swift
//  Todoey
//
//  Created by Ruchir Vallabh on 12/09/18.
//  Copyright © 2018 Ruchir Vallabh. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    
    
    //Mark: 1 Todo items array
   // var itemArray = ["Find Mike", "Buy Eggs", "Bla", "bla"]// Create Model instead
    var itemArray = [Item]()// changing itemArray to an array of Item objects
    //so change i code is required
    
    
    
    //Mark: 5 Create user defaults
    let defaults = UserDefaults.standard //interface to user defaults data base of key value pairs srored persistently
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let newItem = Item()
        newItem.title = "Find mike"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Find mike"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Find mike"
        itemArray.append(newItem3)
        
        
        
        
        if let items = defaults.array(forKey: "TodoListArray") as? [Item]//8
        {// not executed if there is no defaults plist so avoiding crash
        itemArray = items
        }// info now persists in plist file in sandbox
        
        
    }
    
    
    
    
    
    //Mark: - 2 tableview datasource methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count // give num of rows
    
    
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("cellForRowAt indexPath called")//change
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        //cell.textLabel?.text = itemArray[indexPath.row]// set cell's lable
       
      
        
//        cell.textLabel?.text = itemArray[indexPath.row].title//change for Item object
//
//        if itemArray[indexPath.row].done == true {
//            cell.accessoryType = .checkmark
//        } else {
//            cell.accessoryType = .none
//        }//changer for model
        
        //                  ↑
        //         Change above to bellow//does same job
        //                          ↓
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        
        
//        if item.done == true {
//                        cell.accessoryType = .checkmark
//                    } else {
//                        cell.accessoryType = .none
//                    }
        
        //                  ↑
        //         Change above to bellow//does same job
        //                          ↓
        
        cell.accessoryType = item.done ? .checkmark : .none // Ternary Operator
        
        
        
        return cell //creating a reusable cell
    }

    
    
    
    
    
     //Mark: - 3 Table View Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(indexPath.row)
//        print(itemArray[indexPath.row])
//
        
        
//        //adds checkmark to cell when selected
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark //if cell has checkmark
//        {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        } else {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//               }
        
        
        
        
        
//        if itemArray[indexPath.row].done == false {
//            itemArray[indexPath.row].done = true
//        } else {
//             itemArray[indexPath.row].done = false
//        }// change for model

        //                  ↑
        //         Change above to bellow//does same job
        //                          ↓
       
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done//using ! not operator
        //if rhs is true, it becomes false and vice versa
        
        
        tableView.reloadData()//change
        tableView.deselectRow(at: indexPath, animated: true)// flash/blink effect when selected
        
       } //action when a cell is pressed/selected/tapped
    
    
    
    
    
    
    //Mark: - 4 add BarButton to add New Items
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
         var textField = UITextField() //*local var
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)// to add new Item and append it to itemArray
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what happens when user clicks "Add Item" Button on this UIAlet
            print("new Todoey Item Added")
            
            print(textField.text!)//force unwrap dangerous
            
            let  newItem = Item()
            newItem.title = textField.text!
            
//            self.itemArray.append(textField.text ?? "New Item")//if textfield.text is empty return "new item, else return textfield.text
            
            self.itemArray.append(newItem)// change
            
            self.defaults.set(self.itemArray, forKey: "TodoListArray")//7 Save itemArray to userdefaults
            
            self.tableView.reloadData()//reloads table view with added item.
            
        }//completion block when add item is pressed
        
        alert.addTextField { (alertTextField) /*our name given to alert's textfield. it will be limited to this closure*/ in
            alertTextField.placeholder = "Create item"
            textField = alertTextField
            
            print(alertTextField.text ?? "see addTextField closure")  //<- * print will not give any output as nothing is given to textField till user pressed add new item
                           }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
}

