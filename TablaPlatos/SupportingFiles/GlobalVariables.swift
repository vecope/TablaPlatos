//
//  GlobalVariables.swift
//  TablaPlatos
//
//  Created by Camilo Alfonso on 11/10/17.
//  Copyright © 2017 Camilo Alfonso. All rights reserved.
//

import Foundation

struct GlobalVariable{
    static var sharedInstance = GlobalVariable()
    var ultimoPlatoSeleccionado: Plato!
}
