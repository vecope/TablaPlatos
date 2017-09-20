//
//  Plato.swift
//  TablaPlatos
//
//  Created by Camilo Alfonso on 20/09/17.
//  Copyright © 2017 Camilo Alfonso. All rights reserved.
//

import UIKit

class Plato: NSObject {
    
    var id: Int!
    var nombre: String?
    var precio: Int?
    var imagen: String?
    
    override init() {
        super.init()
    }
    
    convenience init(_ dictionary: Dictionary<String, AnyObject>) {
        self.init()
        
        id = dictionary["id"] as! Int
        nombre = dictionary["nombre"] as? String
        precio = dictionary["precio"] as? Int
        imagen = dictionary["imagen"] as? String
    }
}

