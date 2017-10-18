//
//  TablaPlatosTests.swift
//  TablaPlatosTests
//
//  Created by Camilo Alfonso on 20/09/17.
//  Copyright © 2017 Camilo Alfonso. All rights reserved.
//

import XCTest
@testable import TablaPlatos

class TablaPlatosTests: XCTestCase {
    
    
    var platosTest:[Plato] = [Plato]()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let plato1 = Plato([
            "id" : 1 as AnyObject,
            "nombre" : "Plato A" as AnyObject,
            "precio" : 2000 as AnyObject,
            "imagen" : "URL" as AnyObject
            ])
        
        let plato2 = Plato([
            "id" : 2 as AnyObject,
            "nombre" : "Plato B" as AnyObject,
            "precio" : 1350 as AnyObject,
            "imagen" : "URL2" as AnyObject
            ])
        
        platosTest.append(plato1)
        platosTest.append(plato2)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssert(true)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            var procesados = 0
            for platoTemp in self.platosTest{
                print(platoTemp.nombre!)
                procesados += 1
            }
            XCTAssert(procesados==2, "Se esperaban 2 platos procesados")
            // Put the code you want to measure the time of here.
        }
    }
    
}
