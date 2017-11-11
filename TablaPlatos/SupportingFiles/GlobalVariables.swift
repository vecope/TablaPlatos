//
//  GlobalVariables.swift
//  TablaPlatos
//
//  Created by Camilo Alfonso on 11/10/17.
//  Copyright © 2017 Camilo Alfonso. All rights reserved.
//

import Foundation
import CoreData

class GlobalVariables: NSObject {
    
    //Ultimo plato seleccionado en la tabla de platos
    var ultimoPlatoSeleccionado: NSManagedObject? = nil
    var segmentedState: Int = 1
    
    static let sharedInstance = GlobalVariables()
    //Previene que otras clases usen el '()' inicializador de esta clase
    private override init() {
    }
}
