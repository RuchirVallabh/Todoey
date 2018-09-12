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
    var itemArray = ["Find Mike", "Buy Eggs", "Bla", "bla"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //Mark: - 2 tableview datasource methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count // give num of rows
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]// set cell's lable
        return cell //creating a reusable cell
    }
    
    
    
     //Mark: - 3 Table View Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        print(itemArray[indexPath.row])
        
        
        //adds checkmark to cell when selected
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark //if cell has checkmark
        {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
               }
        
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
            self.itemArray.append(textField.text ?? "New Item")//if textfield.text is empty return "new item, else return textfield.text
            
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

