//
//  TablaPlatosUITests.swift
//  TablaPlatosUITests
//
//  Created by Camilo Alfonso on 20/09/17.
//  Copyright © 2017 Camilo Alfonso. All rights reserved.
//

import XCTest

class TablaPlatosUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let app = XCUIApplication()
        let stopButton = app.navigationBars["Pedido"].buttons["Stop"]
        stopButton.tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["9000"]/*[[".cells.staticTexts[\"9000\"]",".staticTexts[\"9000\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        stopButton.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["11000"]/*[[".cells.staticTexts[\"11000\"]",".staticTexts[\"11000\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Obtener info Acelerometro"].tap()
        app.buttons["Hacer pedido"].tap()
        app.alerts["Nombre vacío"].buttons["Cerrar"].tap()
        stopButton.tap()
                        
    }
    
}
