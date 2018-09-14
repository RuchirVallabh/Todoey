//
//  Item.swift
//  Todoey
//
//  Created by Ruchir Vallabh on 13/09/18.
//  Copyright © 2018 Ruchir Vallabh. All rights reserved.
//

import Foundation


class Item: /*Encodable, Decodable*/ Codable
{//Conforming to Encodable Protocol
    
    var title: String = ""
    var done:Bool = false
}
