//
//  NationalGalarPokedexUITests.swift
//  NationalGalarPokedexUITests
//
//  Created by Hector Villasano on 7/21/20.
//  Copyright © 2020 s. All rights reserved.
//

import XCTest

class NationalGalarPokedexUITests: XCTestCase {
    var app: XCUIApplication! = nil

    var searchNavigationBar: XCUIElement {
        app.navigationBars["PokedexSearchNavigationBar"]
    }
    
    var pokedexListTableView: XCUIElement {
        app.tables["PokedexListTableView"]
    }
    
    var rightBarButtonItemMagnifyingglass: XCUIElement {
        searchNavigationBar.buttons["rightBarButtonItemMagnifyingglass"]
    }
    
    var leftBarButtonItemGear: XCUIElement {
        searchNavigationBar.buttons["leftBarButtonItemGear"]
    }
    
    var searchTabBarButton: XCUIElement {
        app.tabBars.buttons["Search"]
    }
    
    var favoritesTabBarButton: XCUIElement {
        app.tabBars.buttons["Favorites"]
    }
    
    var leagueCardTabBarButton: XCUIElement {
        app.tabBars.buttons["League Cards"]
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        sleep(1)
        app.terminate()
    }
}

extension NationalGalarPokedexUITests {
    func testPokedexSearchNavigationBarIsHittable() throws {
        XCTAssert(searchNavigationBar.isHittable)
    }
    
    func testpokedexListTableViewIsHittable() throws {
        XCTAssert(pokedexListTableView.isHittable)
    }
    
    func testTabBarButtonsIsHittable() {
        XCTAssert(searchTabBarButton.isHittable)
        XCTAssert(favoritesTabBarButton.isHittable)
        XCTAssert(leagueCardTabBarButton.isHittable)
    }
    
    func testTBulbasaurDetailViewFlow() throws {
        pokedexListTableView.cells["BulbasaurCell"].tap()
        
        XCTAssert(app.navigationBars["BulbasaurDetailView"].isHittable)
        
        let playPauseButton = app.buttons["playpause"]
        
        XCTAssert(playPauseButton.isHittable)
        playPauseButton.tap()
        
        let tablesQuery = app.tables
        
        tablesQuery.buttons["Description"].tap()
        sleep(1)
        
        tablesQuery.staticTexts["National:  #1"].tap()
        sleep(1)
        
        tablesQuery.staticTexts["NO."].tap()
        sleep(1)
        
        tablesQuery.staticTexts["Type"].tap()
        sleep(1)
        
        tablesQuery.staticTexts["Height & Weight"].tap()
        sleep(1)
        
        app.swipeUp()
        app.swipeUp()
        app.swipeUp()
                
        searchTabBarButton.tap()
        XCTAssert(searchNavigationBar.isHittable)
    }
}

// MARK: METRICS
extension NationalGalarPokedexUITests {
    func _testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
