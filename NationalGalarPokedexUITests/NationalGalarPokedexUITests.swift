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
    func pokemonDetailViewFlow(name: String, enableDetailViewSections: Bool = false, enableAudio: Bool = false) throws -> Bool {
        let detailViewSections = ["Description", "NO.", "Type", "Height & Weight", "Base Stats", "Hatch Cycles", "Exp Group", "Egg groups", "Egg Moves", "Abilities", "Level Up Moves"]
        
        let pokemonDetailViewNaviationBar = app.navigationBars["\(name)DetailView"]
        if !pokemonDetailViewNaviationBar.isHittable {
            throw NationalGalarPokedexUITestsError.pokemonDetailViewFlowError
        }
        
        let playPauseButton = app.buttons["playpause"]
        if !playPauseButton.isHittable {
            throw NationalGalarPokedexUITestsError.pokemonDetailViewFlowError
        }
        
        if enableAudio {
            playPauseButton.tap()
        }
        
        let tablesQuery = app.tables
        
        if enableDetailViewSections {
            for section in detailViewSections {
                let button = tablesQuery.buttons[section]
                if !button.isHittable {
                    throw NationalGalarPokedexUITestsError.pokemonDetailViewFlowError
                }
                
                button.tap()
            }
        }
        
        let serebiiButton = pokemonDetailViewNaviationBar.buttons["serebii.net"]
        if !serebiiButton.isHittable {
            throw NationalGalarPokedexUITestsError.pokemonDetailViewFlowError
        }
        
        serebiiButton.tap()
        pokemonDetailViewNaviationBar.buttons["\(name)"].tap()
        
        return true
    }
    
    func navigateToNationalPokemonTableViewList() throws -> Bool {
        if !searchTabBarButton.isHittable {
            throw NationalGalarPokedexUITestsError.navigateToNationalPokemonTableViewListError
        }
        searchTabBarButton.tap()
        
        if !leftBarButtonItemGear.isHittable {
            throw NationalGalarPokedexUITestsError.navigateToNationalPokemonTableViewListError
        }
        leftBarButtonItemGear.tap()
        
        if !pokedexNOSheet.isHittable {
            throw NationalGalarPokedexUITestsError.navigateToNationalPokemonTableViewListError
        }
        pokedexNOSheetButtons[0].tap()
        
        if !searchListTableView.cells["\(nationalPokemonNames[0])Cell"].isHittable {
            throw NationalGalarPokedexUITestsError.navigateToNationalPokemonTableViewListError
        }
        
        return true
    }
    
    func navigateToGalarPokemonTableViewList() throws -> Bool {
        if !searchTabBarButton.isHittable {
            throw NationalGalarPokedexUITestsError.navigateToNationalPokemonTableViewListError
        }
        searchTabBarButton.tap()
        
        if !leftBarButtonItemGear.isHittable {
            throw NationalGalarPokedexUITestsError.navigateToNationalPokemonTableViewListError
        }
        leftBarButtonItemGear.tap()
        
        if !pokedexNOSheet.isHittable {
            throw NationalGalarPokedexUITestsError.navigateToNationalPokemonTableViewListError
        }
        
        pokedexNOSheetButtons[1].tap()
        if !searchListTableView.cells["\(galarPokemonNames[0])Cell"].isHittable {
            throw NationalGalarPokedexUITestsError.navigateToNationalPokemonTableViewListError
        }
        
        return true
    }
    
    func viewAllPokemonFlow(with list: [String]) throws -> Bool {
        if !searchTabBarButton.isHittable {
            throw NationalGalarPokedexUITestsError.viewAllPokemonFlowError
        }
        searchTabBarButton.tap()
        
        if !searchTabBarButton.isSelected {
            throw NationalGalarPokedexUITestsError.viewAllPokemonFlowError
        }
        
        for name in list {
            let pokemonCellID = "\(name)Cell"
            
            if !searchListTableView.cells[pokemonCellID].isHittable {
                throw NationalGalarPokedexUITestsError.viewAllPokemonFlowError
            }
            searchListTableView.cells[pokemonCellID].tap()
            
            XCTAssertNoThrow(try pokemonDetailViewFlow(name: name), "pokemonDetailViewFlow")
            
            if !searchTabBarButton.isHittable {
                throw NationalGalarPokedexUITestsError.viewAllPokemonFlowError
            }
            searchTabBarButton.tap()
            
            if !searchNavigationBar.isHittable {
                throw NationalGalarPokedexUITestsError.viewAllPokemonFlowError
            }
        }
        
        return true
    }
    
    func favoriteAllPokemonFlow(with list: [String]) throws -> Bool {
        searchTabBarButton.tap()
        if !searchTabBarButton.isSelected {
            throw NationalGalarPokedexUITestsError.favoriteAllPokemonFlowError
        }
        
        for name in list {
            let pokemonCell = searchListTableView.cells["\(name)Cell"]
            
            if !pokemonCell.isHittable {
                throw NationalGalarPokedexUITestsError.favoriteAllPokemonFlowError
            }
            
            let cellHeartButton = pokemonCell.buttons["heart"]
            
            if !cellHeartButton.isHittable {
                app.swipeUp()
            }
            
            cellHeartButton.tap()
            
            if !favoritesTabBarButton.isHittable {
                throw NationalGalarPokedexUITestsError.favoriteAllPokemonFlowError
            }
            favoritesTabBarButton.tap()
            
            if !favoritesTabBarButton.isSelected {
                throw NationalGalarPokedexUITestsError.favoriteAllPokemonFlowError
            }
            
            let collectionViewPokemonCell = app.collectionViews.cells["\(name)Cell"]
            
            if !collectionViewPokemonCell.isHittable {
                throw NationalGalarPokedexUITestsError.favoriteAllPokemonFlowError
            }
            collectionViewPokemonCell.tap()
            
            XCTAssertNoThrow(try pokemonDetailViewFlow(name: name), "pokemonDetailViewFlow")
            
            favoritesTabBarButton.tap()
            if !favoritesTabBarButton.isSelected {
                throw NationalGalarPokedexUITestsError.favoriteAllPokemonFlowError
            }
            
            if !searchTabBarButton.isHittable {
                throw NationalGalarPokedexUITestsError.favoriteAllPokemonFlowError
            }
            searchTabBarButton.tap()
            
            if !searchTabBarButton.isSelected {
                throw NationalGalarPokedexUITestsError.favoriteAllPokemonFlowError
            }
            
            let cellHeartFillButton = pokemonCell.buttons["heart.fill"]
            XCTAssert(cellHeartFillButton.isHittable)
            cellHeartFillButton.tap()
            
        }
        return true
    }
    
    func navigateToLeagueCardView() throws -> Bool {
        if !leagueCardTabBarButton.isHittable {
            throw NationalGalarPokedexUITestsError.navigateToLeagueCardViewError
        }
        leagueCardTabBarButton.tap()
        
        if !leagueCardTabBarButton.isSelected {
            throw NationalGalarPokedexUITestsError.navigateToLeagueCardViewError
        }
        
        if !leagueCardsTableView.isHittable {
            throw NationalGalarPokedexUITestsError.navigateToLeagueCardViewError
        }
        
        return true
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
        
        XCTAssertNoThrow(try pokemonDetailViewFlow(name: pokemon, enableDetailViewSections: true, enableAudio: true), "pokemonDetailViewFlow")

        navBar.buttons["⚔️🛡Pokedex"].tap()
    }
}
