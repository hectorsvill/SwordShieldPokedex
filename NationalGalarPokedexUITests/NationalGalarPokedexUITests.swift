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
    
    func leagueCardViewCellTapped(with cell: String) throws -> Bool {
        let cardCodeCell = leagueCardsTableView.cells[cell]
        if !cardCodeCell.isHittable {
            throw NationalGalarPokedexUITestsError.leagueCardViewCellTappedError
        }
        cardCodeCell.tap()
        
        let myCardCodeNavBar = app.navigationBars["My Card Code"]
        if !myCardCodeNavBar.isHittable {
            throw NationalGalarPokedexUITestsError.leagueCardViewCellTappedError
        }
        
        if app.textFields.count != 4 {
            throw NationalGalarPokedexUITestsError.leagueCardViewCellTappedError
        }
        
        let myCardCodeNavBarInfoButton = myCardCodeNavBar.buttons["info.circle"]
        if !myCardCodeNavBarInfoButton.isHittable {
            throw NationalGalarPokedexUITestsError.leagueCardViewCellTappedError
        }
        myCardCodeNavBarInfoButton.tap()
        
        let serebiiView = app.navigationBars["HSVSerebiiView"]
        if !serebiiView.isHittable {
            throw NationalGalarPokedexUITestsError.leagueCardViewCellTappedError
        }
                
        let backButton = serebiiView.buttons["My Card Code"]
        if !backButton.isHittable {
            throw NationalGalarPokedexUITestsError.leagueCardViewCellTappedError
        }
        backButton.tap()
        
        if !cardCodeNavBarBackButton.isHittable {
            throw NationalGalarPokedexUITestsError.leagueCardViewCellTappedError
        }
        cardCodeNavBarBackButton.tap()
        
        return true
    }
    
    /// Will click on add league card button to navigate to add league card view. Also works with Account.
    func addLeagueCardFlow() throws -> Bool {
        let leagueCardNavBar = app.navigationBars["League Cards"]
        if !leagueCardNavBar.isHittable {
            throw NationalGalarPokedexUITestsError.addLeagueCardFlowError
        }
        leagueCardNavBar.buttons["plus"].tap()
        
        let errorAlert = app.alerts["iCloud Error"]
        
        if errorAlert.waitForExistence(timeout: 1) {
            if !errorAlert.isHittable {
                throw NationalGalarPokedexUITestsError.addLeagueCardFlowError
            }
            
            let alertOkButton = errorAlert.buttons["OK"]
            if !alertOkButton.isHittable {
                throw NationalGalarPokedexUITestsError.addLeagueCardFlowError
            }
            alertOkButton.tap()
        }
        
        return true
    }
    
    func AddLeagueCardResetButtonFlow() throws -> Bool{
        let resetButton = app.buttons["Reset"]
        if !resetButton.isHittable {
            throw NationalGalarPokedexUITestsError.AddLeagueCardResetButtonFlowError
        }
        resetButton.tap()
        return true
    }
        
    func searchPokemonSearchBarTappedFlow() throws -> Bool {
        searchTabBarButton.tap()
        if !searchTabBarButton.isSelected {
            throw NationalGalarPokedexUITestsError.searchPokemonSearchBarTappedFlowError
        }
        
        if !rightBarButtonItemMagnifyingglass.isHittable {
            throw NationalGalarPokedexUITestsError.searchPokemonSearchBarTappedFlowError
        }
        
        if searchPokemonSearchBar.waitForExistence(timeout: 1) {
            throw NationalGalarPokedexUITestsError.searchPokemonSearchBarTappedFlowError
        }
        
        rightBarButtonItemMagnifyingglass.tap()
        
        if !searchPokemonSearchBar.isHittable {
            throw NationalGalarPokedexUITestsError.searchPokemonSearchBarTappedFlowError
        }
        searchPokemonSearchBar.tap()
        
        return true
    }
    
    func searchBarSearchForPokemonFlow(with pokemon: String, searchString: String) throws -> Bool {
        guard try searchPokemonSearchBarTappedFlow() else { throw NationalGalarPokedexUITestsError.searchForNationalPokemonFlowError }
        
        if !searchPokemonSearchBar.isHittable {
            throw NationalGalarPokedexUITestsError.searchPokemonSearchBarTappedFlowError
        }
        searchPokemonSearchBar.tap()
        
        searchString.forEach {
            app.keys[String($0)].tap()
        }
        
        if !rightBarButtonItemMagnifyingglass.isHittable {
            throw NationalGalarPokedexUITestsError.searchPokemonSearchBarTappedFlowError
        }
        rightBarButtonItemMagnifyingglass.tap()
        
        let pokemonCell = searchListTableView.cells["\(pokemon)Cell"]
        if !pokemonCell.isHittable {
            throw NationalGalarPokedexUITestsError.searchPokemonSearchBarTappedFlowError
        }
        pokemonCell.tap()
        
        let navBar = app.navigationBars["\(pokemon)DetailView"]
        if !navBar.isHittable {
            throw NationalGalarPokedexUITestsError.searchPokemonSearchBarTappedFlowError
        }
        
        guard try pokemonDetailViewFlow(name: pokemon, enableDetailViewSections: true, enableAudio: true) else { throw NationalGalarPokedexUITestsError.searchPokemonSearchBarTappedFlowError }

        navBar.buttons["⚔️🛡Pokedex"].tap()
        
        return true
    }
}
