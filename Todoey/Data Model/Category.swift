//
//  Category.swift
//  Todoey
//
//  Created by Ruchir Vallabh on 20/09/18.
//  Copyright © 2018 Ruchir Vallabh. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
    
    
    @objc dynamic var name : String = ""
    @objc dynamic var color : String = ""
    let items = List<Item>()
}
