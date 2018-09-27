//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Ruchir Vallabh on 19/09/18.
//  Copyright © 2018 Ruchir Vallabh. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework




class CategoryViewController: SwipeTableViewController {


  
    let realm = try! Realm()

    var categories : Results<Category>?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       loadCategories()
        
        tableView.separatorStyle = .none
        
    }

    
    
    
     //MARK: - Table View DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categories?.count ?? 1
    }
    
    
    
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories added yet"
    
        guard let categoryColour =  UIColor(hexString: categories?[indexPath.row].color ?? "FF8AD8") else {   fatalError()   }
        
        cell.backgroundColor = categoryColour

        cell.textLabel?.textColor = ContrastColorOf(categoryColour, returnFlat: true)
        
        return cell
        
    }
    
    
    

    
     //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        //tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "goToItems", sender: self)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
    
    
    
    
    
    
     //MARK: - Data Manipulation Methods CRUD
    
    func save(category: Category) {
        
        
        do {
            
            try realm.write {
                realm.add(category)
            }
        }
        catch{
            print("error saving context \(error)")
        }
        
        tableView.reloadData()
    }
    
    
    
    func loadCategories()
    {
        
        categories = realm.objects(Category.self)
        
        
       tableView.reloadData()
        
    }
    
    //Mark: Delete data from Swipe
    
    
    override func updateModel(at indexPath: IndexPath) {
        
        super.updateModel(at: indexPath)// print statement in superclass will not be shown without super keyword as we are overriding the func in superclass
        
        if let categoryForDeletion = self.categories?[indexPath.row]{
            
                do{
                    try realm.write {
                         print("deleted from sub class")
                        realm.delete(categoryForDeletion) // to delete Item

                    }
                }catch {
                    print("Error Deleting Category, \(error)")
                }
         
            }
               
    }
    
    
    
    
    
    
     //MARK: - ADD new Categories
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            print("new Category Added")
            
          
            
            let  newCategory = Category()
            
            
            newCategory.name = textField.text!
            newCategory.color = UIColor.randomFlat.hexValue()
            
            self.save(category: newCategory)
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create Category"
            textField = alertTextField
            
            print(alertTextField.text ?? "see Create Category Field closure")
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    

    
}




