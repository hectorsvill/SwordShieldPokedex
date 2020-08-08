//
//  NationalGalarPokedexUITests+UIElements.swift
//  NationalGalarPokedexUITests
//
//  Created by Hector Villasano on 8/1/20.
//  Copyright © 2020 s. All rights reserved.
//

import XCTest

extension NationalGalarPokedexUITests {
    var searchNavigationBar: XCUIElement {
        app.navigationBars["PokedexSearchNavigationBar"]
    }
    
    var googleMobileAddsBannerView: XCUIElement {
        searchListTableViewController.otherElements.matching(identifier: "GoogleMobileAddsBannerView").element
    }
    
    var searchListTableViewController: XCUIElement {
        app.tables["PokedexListTableView"]
    }
    
    var leagueCardsTableViewController: XCUIElement {
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
    
    var searchPokemonSearchBar: XCUIElement {
        app.staticTexts["SearchPokemonSearchBar"]
    }
    
    var cardCodeNavBarBackButton: XCUIElement {
        app.navigationBars["My Card Code"].buttons["League Cards"]
    }
    
    var addLeagueCardIDViewTexdFieldA: XCUIElement {
        app.textFields["SectionATextField"]
    }
    
    var addLeagueCardIDViewTexdFieldB: XCUIElement {
        app.textFields["SectionBTextField"]
    }
    
    var addLeagueCardIDViewTexdFieldC: XCUIElement {
        app.textFields["SectionCTextField"]
    }
    var addLeagueCardIDViewTexdFieldD: XCUIElement {
        app.textFields["SectionDTextField"]
    }
}
