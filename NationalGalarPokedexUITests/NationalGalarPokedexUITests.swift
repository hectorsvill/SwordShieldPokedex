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
    let mocData = NationalGalarPokedexUITestsMocData()
    var nationalPokemonNames = NationalGalarPokedexUITestsMocData.nationalPokemonNames()
    var galarPokemonNames = NationalGalarPokedexUITestsMocData.galarPokemonNames()
    
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

// MARK: - UI Flows
extension NationalGalarPokedexUITests {
    
    func pokemonDetailViewFlow(name: String, enableDetailViewSections: Bool = false, enableAudio: Bool = false) {
        let detailViewSections = ["Description", "NO.", "Type", "Height & Weight", "Base Stats", "Hatch Cycles", "Exp Group", "Egg groups", "Egg Moves", "Abilities", "Level Up Moves"]
        
        let pokemonDetailViewNaviationBar = app.navigationBars["\(name)DetailView"]
        XCTAssert(pokemonDetailViewNaviationBar.isHittable)
        
        let playPauseButton = app.buttons["playpause"]
        XCTAssert(playPauseButton.isHittable)
        
        if enableAudio {
            playPauseButton.tap()
        }
        
        let tablesQuery = app.tables
        
        if enableDetailViewSections {
            for section in detailViewSections {
                let button = tablesQuery.buttons[section]
                XCTAssert(button.isHittable)
                button.tap()
            }
        }
        
        let serebiiButton = pokemonDetailViewNaviationBar.buttons["serebii.net"]
        XCTAssert(serebiiButton.isHittable)
        serebiiButton.tap()
        
        pokemonDetailViewNaviationBar.buttons["\(name)"].tap()
    }
    
    func navigateToNationalPokemonTableViewList() {
        searchTabBarButton.tap()
        leftBarButtonItemGear.tap()
        XCTAssert(pokedexNOSheet.isHittable)
        pokedexNOSheetButtons[0].tap()
        sleep(1)
        XCTAssert(searchListTableView.cells["\(nationalPokemonNames[0])Cell"].isHittable)
    }
    
    func navigateToGalarPokemonTableViewList() {
        searchTabBarButton.tap()
        leftBarButtonItemGear.tap()
        XCTAssert(pokedexNOSheet.isHittable)
        pokedexNOSheetButtons[1].tap()
        sleep(1)
        XCTAssert(searchListTableView.cells["\(galarPokemonNames[0])Cell"].isHittable)
    }
    
    func viewAllPokemonFlow(with list: [String]) {
        searchTabBarButton.tap()
        XCTAssert(searchTabBarButton.isSelected)
        for name in list {
            let pokemonCellID = "\(name)Cell"
            
            searchListTableView.cells[pokemonCellID].tap()
            
            pokemonDetailViewFlow(name: name)
            
            searchTabBarButton.tap()
            XCTAssert(searchNavigationBar.isHittable)
        }
    }
    
    func favoriteAllPokemonFlow(with list: [String]) {
        searchTabBarButton.tap()
        XCTAssert(searchTabBarButton.isSelected)
        for name in list {
            let cell = searchListTableView.cells["\(name)Cell"]
            
            let cellHeartButton = cell.buttons["heart"]
            
            if !cellHeartButton.isHittable {
                app.swipeUp()
            }
            
            cellHeartButton.tap()
            
            XCTAssert(favoritesTabBarButton.isHittable)
            favoritesTabBarButton.tap()
            XCTAssert(favoritesTabBarButton.isSelected)
            
            app.collectionViews.cells["\(name)Cell"].tap()
            
            pokemonDetailViewFlow(name: name)
            
            favoritesTabBarButton.tap()
            XCTAssert(favoritesTabBarButton.isSelected)
            
            XCTAssert(searchTabBarButton.isHittable)
            searchTabBarButton.tap()
            XCTAssert(searchTabBarButton.isSelected)
            
            let cellHeartFillButton = cell.buttons["heart.fill"]
            XCTAssert(cellHeartFillButton.isHittable)
            cellHeartFillButton.tap()
        }
    }
    
    func navigateToLeagueCardView() {
        XCTAssert(leagueCardTabBarButton.isHittable)
        leagueCardTabBarButton.tap()
        XCTAssert(leagueCardTabBarButton.isSelected)
        XCTAssert(leagueCardsTableView.isHittable)
    }
    
    func leagueCardViewCellTapped(with cell: String) {
        let cardCodeCell = leagueCardsTableView.cells[cell]
        XCTAssert(cardCodeCell.isHittable)
        cardCodeCell.tap()
        
        let myCardCodeNavBar = app.navigationBars["My Card Code"]
        XCTAssert(myCardCodeNavBar.isHittable)
        
        XCTAssertTrue(app.textFields.count == 4)
        
        let myCardCodeNavBarInfoButton = myCardCodeNavBar.buttons["info.circle"]
        XCTAssert(myCardCodeNavBarInfoButton.isHittable)
        myCardCodeNavBarInfoButton.tap()
        
        let serebiiView = app.navigationBars["HSVSerebiiView"]
        XCTAssert(serebiiView.isHittable)
        
        
        let backButton = serebiiView.buttons["My Card Code"]
        XCTAssert(backButton.isHittable)
        backButton.tap()
        
        XCTAssert(cardCodeNavBarBackButton.isHittable)
        cardCodeNavBarBackButton.tap()
    }
    
    
    /// Will click on add league card button to navigate to add league card view. Also works with Account.
    func addLeagueCardFlow() {
        let leagueCardNavBar = app.navigationBars["League Cards"]
        XCTAssert(leagueCardNavBar.isHittable)
        leagueCardNavBar.buttons["plus"].tap()
        
        let errorAlert = app.alerts["iCloud Error"]
        
        if errorAlert.waitForExistence(timeout: 1) {
            XCTAssert(errorAlert.isHittable)
            
            let alertOkButton = errorAlert.buttons["OK"]
            XCTAssert(alertOkButton.isHittable)
            alertOkButton.tap()
        }
    }
    
    func AddLeagueCard_ResetButtonFlow() {
        let resetButton = app.buttons["Reset"]
        XCTAssert(resetButton.isHittable)
        resetButton.tap()
    }
        
    func searchPokemonSearchBarTappedFlow() {
        searchTabBarButton.tap()
        XCTAssert(searchTabBarButton.isSelected)
        XCTAssert(rightBarButtonItemMagnifyingglass.isHittable)
        XCTAssertFalse(searchPokemonSearchBar.waitForExistence(timeout: 1))
        rightBarButtonItemMagnifyingglass.tap()
        XCTAssert(searchPokemonSearchBar.isHittable)
        searchPokemonSearchBar.tap()
    }
    
    func searchForNationalPokemonFlow(with pokemon: String, searchString: String) {
        searchPokemonSearchBarTappedFlow()
        XCTAssert(searchPokemonSearchBar.isHittable)
        searchPokemonSearchBar.tap()
        
        searchString.forEach {
            app.keys[String($0)].tap()
        }
        
        XCTAssert(rightBarButtonItemMagnifyingglass.isHittable)
        rightBarButtonItemMagnifyingglass.tap()
        
        let pokemonCell = searchListTableView.cells["\(pokemon)Cell"]
        XCTAssert(pokemonCell.isHittable)
        pokemonCell.tap()
        
        let navBar = app.navigationBars["\(pokemon)DetailView"]
        XCTAssert(navBar.isHittable)
        
        pokemonDetailViewFlow(name: pokemon, enableDetailViewSections: true, enableAudio: true)
        
        navBar.buttons["⚔️🛡Pokedex"].tap()
    }
}
