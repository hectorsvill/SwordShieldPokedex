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
    let mocData = NationalGalarPokedexUITestsMocData(nationalPokemonNames: [.Bulbasaur], galarPokemonNames: [.Grookey])
    var nationalPokemonNames = [NationalPokemonNames]()
    var galarPokemonNames = [GalarPokemonNames]()
    
    var fetchGalarNameRawValues: [String] {
        self.galarPokemonNames.map { return $0.rawValue }
    }
    
    var fetchNationalNamesRawValues: [String] {
        self.nationalPokemonNames.map { return $0.rawValue }
    }
    
    override func setUpWithError() throws {
        nationalPokemonNames = mocData.nationalPokemonNames
        galarPokemonNames = mocData.galarPokemonNames
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app.terminate()
    }
}

// MARK: - Comon XCUIElements
extension NationalGalarPokedexUITests {
    var searchNavigationBar: XCUIElement {
        app.navigationBars["PokedexSearchNavigationBar"]
    }
    
    var searchListTableView: XCUIElement {
        app.tables["PokedexListTableView"]
    }
    
    var leagueCardsTableView: XCUIElement {
        app.tables["LeagueCardsTableViewController"]
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
    
    var pokedexNOSheet: XCUIElement {
        app.sheets["Pokedex NO."]
    }
    
    ///buttons["National Pokedex"], buttons["Galar Pokedex"], buttons["Favorite"]
    var pokedexNOSheetButtons: [XCUIElement] {
        [pokedexNOSheet.buttons["National Pokedex"], pokedexNOSheet.buttons["Galar Pokedex"], pokedexNOSheet.buttons["Favorite"]]
    }
    
    var cardCodeNavBarBackButton: XCUIElement {
        app.navigationBars["My Card Code"].buttons["League Cards"]
    }
    
    var searchPokemonSearchBar: XCUIElement {
        app.staticTexts["SearchPokemonSearchBar"]
    }
}

// MARK: METRICS
extension NationalGalarPokedexUITests {
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                app.launch()
            }
        }
    }
}
