//
//  NationalGalarPokedexUITests+Test.swift
//  NationalGalarPokedexUITests
//
//  Created by Hector Villasano on 7/24/20.
//  Copyright © 2020 s. All rights reserved.
//

import XCTest

//MARK: - Search View Test
extension NationalGalarPokedexUITests{
    func testPokemonNameListNotNil() {
        XCTAssertNotNil(nationalPokemonNames)
        XCTAssertNotNil(galarPokemonNames)
    }
    
    func testRightBarButtonItemMagnifyingglassISHittable() {
        XCTAssert(rightBarButtonItemMagnifyingglass.isHittable)
        rightBarButtonItemMagnifyingglass.tap()
    }
    
    func testLeftBarButtonItemGearISHittable() {
        XCTAssert(leftBarButtonItemGear.isHittable)
        leftBarButtonItemGear.tap()
    }
    
    func testPokedexSearchNavigationBarIsHittable() throws {
        XCTAssert(searchNavigationBar.isHittable)
    }
    
    func testpokedexListTableViewIsHittable() throws {
        XCTAssert(searchListTableView.isHittable)
    }
    
    func testTabBarButtonsIsHittable() {
        XCTAssert(favoritesTabBarButton.isHittable)
        favoritesTabBarButton.tap()
        XCTAssert(leagueCardTabBarButton.isHittable)
        leagueCardTabBarButton.tap()
        XCTAssert(searchTabBarButton.isHittable)
        searchTabBarButton.tap()
    }
    
    func testPokedexNOSheetButtonsIsHittable() {
        for button in pokedexNOSheetButtons {
            leftBarButtonItemGear.tap()
            XCTAssert(button.isHittable)
            button.tap()
        }
    }
    
    func testNavigateTonationalPokemonTableViewList() {
        XCTAssertNoThrow(try navigateToNationalPokemonTableViewList(), "navigateToNationalPokemonTableViewList Error")
    }
    
    func testNavigateToGalarPokemonTableViewList() {
        XCTAssertNoThrow(try navigateToGalarPokemonTableViewList(), "navigateToGalarPokemonTableViewList Error")
    }
    
    func testAllNationalPokemonInTableViewIsHittable() {
        XCTAssertNoThrow(try navigateToNationalPokemonTableViewList(), "navigateToNationalPokemonTableViewList Error")
        XCTAssertNoThrow(try viewAllPokemonFlow(with: fetchNationalNamesRawValues), "viewAllPokemonFlow Error")
    }
    
    func testAllGalarPokemonInTableViewIsHittable() {
        XCTAssertNoThrow(try navigateToGalarPokemonTableViewList(), "navigateToGalarPokemonTableViewList Error")
        XCTAssertNoThrow(try viewAllPokemonFlow(with: fetchGalarNameRawValues), "viewAllPokemonFlow Error")
    }
    
    /// pressing the right bar button will show search bar if not present,  remove if present
    func testRightBarButtonItemMagnifyingglassPressed() {
        XCTAssertNoThrow(try searchPokemonSearchBarTappedFlow(), "searchPokemonSearchBarTappedFlow Error")
        rightBarButtonItemMagnifyingglass.tap()
        XCTAssertFalse(searchPokemonSearchBar.waitForExistence(timeout: 1))
    }
        
    /// Use the searchbar to search National pokemon
    func testSearchForNatioanlPokemon() {
        XCTAssert(leftBarButtonItemGear.isHittable)
        leftBarButtonItemGear.tap()
        XCTAssert(pokedexNOSheet.isHittable)
        pokedexNOSheetButtons[0].tap()
        
        let pokemon = nationalPokemonNames.randomElement()!
        let subString = String(pokemon.rawValue.prefix(3))
        XCTAssertNoThrow(try searchBarSearchForPokemonFlow(with: pokemon.rawValue, searchString: subString), "searchForNationalPokemonFlow Error")
        
    }

    /// Use the searchbar to search galar pokemon
    func testSearchForGalarPokemon() {
        XCTAssert(leftBarButtonItemGear.isHittable)
        leftBarButtonItemGear.tap()
        XCTAssert(pokedexNOSheet.isHittable)
        pokedexNOSheetButtons[1].tap()
        
        let pokemon = galarPokemonNames.randomElement()!
        let subString = String(pokemon.rawValue.prefix(3))
        XCTAssertNoThrow(try searchBarSearchForPokemonFlow(with: pokemon.rawValue, searchString: subString), "searchForNationalPokemonFlow Error")
    }
}

// MARK: - Favorite View Test
extension NationalGalarPokedexUITests{
    func testSearchViewFavorites() {
        searchTabBarButton.tap()
        XCTAssert(searchTabBarButton.isSelected)

        let pokemonCell = searchListTableView.cells["\(nationalPokemonNames[0])Cell"]
        
        while !pokemonCell.waitForExistence(timeout: 0.3) {
            app.swipeUp()
        }
        
        XCTAssert(pokemonCell.isHittable)
        
        let cellHeartButton = pokemonCell.buttons["heart"]
        XCTAssert(cellHeartButton.isHittable)
        cellHeartButton.tap()

        leftBarButtonItemGear.tap()
        XCTAssert(pokedexNOSheet.isHittable)
        
        let favoriteButton = pokedexNOSheetButtons[2]
        favoriteButton.tap()
        
        XCTAssert(pokemonCell.isHittable)
        
        let cellHeartFillButton = pokemonCell.buttons["heart.fill"]
        XCTAssertTrue(cellHeartFillButton.isHittable)
        cellHeartFillButton.tap()
        
        let cellExist = pokemonCell.waitForExistence(timeout: 1)
        XCTAssertFalse(cellExist)
        
        leftBarButtonItemGear.tap()
        XCTAssert(pokedexNOSheet.isHittable)
        pokedexNOSheetButtons[0].tap()
    }
    
    func testNationalPokokemonIsFavorite() {
        XCTAssertNoThrow(try navigateToNationalPokemonTableViewList(), "navigateToNationalPokemonTableViewList Error")
        XCTAssertNoThrow(try favoriteAllPokemonFlow(with: fetchNationalNamesRawValues), "favoriteAllPokemonFlow Error")
    }
    
    func testGalarPokokemonIsFavorite() {
        XCTAssertNoThrow(try navigateToGalarPokemonTableViewList(), "navigateToGalarPokemonTableViewList Error")
        XCTAssertNoThrow(try favoriteAllPokemonFlow(with: fetchGalarNameRawValues), "favoriteAllPokemonFlow Error")
    }
}

// MARK: - LEAGUE CARDS VIEW Test
extension NationalGalarPokedexUITests{
    func testLeagueCardView() {
        XCTAssertNoThrow(try navigateToLeagueCardView(), "navigateToLeagueCardView Error")
    }
    
    func testLeagueCardViewCellTapped() {
        XCTAssertNoThrow(try navigateToLeagueCardView(), "navigateToLeagueCardView Error")
        XCTAssertNoThrow(try  leagueCardViewCellTapped(with: "0000 0000 0000 00"), "leagueCardViewCellTapped Cell")
        XCTAssert(searchTabBarButton.isHittable)
        searchTabBarButton.tap()
        XCTAssert(searchTabBarButton.isSelected)
    }
    
    func testAddLeagueCardNoiCloudAccountError() {
        XCTAssertNoThrow(try navigateToLeagueCardView(), "navigateToLeagueCardView Error")
        XCTAssertNoThrow(try addLeagueCardFlow(), "addLeagueCardFlow Error")
        XCTAssert(cardCodeNavBarBackButton.isHittable)
        cardCodeNavBarBackButton.tap()
    }
    
    func testAddLeagueCardSubmitEmptyCodeButtonError() {
        XCTAssertNoThrow(try navigateToLeagueCardView(), "navigateToLeagueCardView Error")
        XCTAssertNoThrow(try addLeagueCardFlow(), "addLeagueCardFlow Error")
        
        let submitButton = app.buttons["Submit"]
        XCTAssert(submitButton.isHittable)
        submitButton.tap()
        
        let alertOKButton = app.alerts["Error"].buttons["OK"]
        XCTAssert(alertOKButton.isHittable)
        alertOKButton.tap()
        
        XCTAssert(cardCodeNavBarBackButton.isHittable)
        cardCodeNavBarBackButton.tap()
    }
    
    func testAddLeagueCardResetButtonisHitable() {
        XCTAssertNoThrow(try navigateToLeagueCardView(), "navigateToLeagueCardView Error")
        XCTAssertNoThrow(try addLeagueCardFlow(), "addLeagueCardFlow Error")
        XCTAssertNoThrow(try AddLeagueCardResetButtonFlow(), "AddLeagueCardResetButtonFlow Error")
        XCTAssert(cardCodeNavBarBackButton.isHittable)
        cardCodeNavBarBackButton.tap()
    }
}

// MARK: - UI Flows
extension NationalGalarPokedexUITests {
    private func pokemonDetailViewFlow(name: String, enableDetailViewSections: Bool = false, enableAudio: Bool = false) throws -> Bool {
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
    
    private func navigateToNationalPokemonTableViewList() throws -> Bool {
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

        return true
    }
    
    private func navigateToGalarPokemonTableViewList() throws -> Bool {
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
        
        return true
    }
    
    private func viewAllPokemonFlow(with list: [String]) throws -> Bool {
        if !searchTabBarButton.isHittable {
            throw NationalGalarPokedexUITestsError.viewAllPokemonFlowError
        }
        searchTabBarButton.tap()
        
        if !searchTabBarButton.isSelected {
            throw NationalGalarPokedexUITestsError.viewAllPokemonFlowError
        }
        
        for name in list {
            let pokemonCellID = "\(name)Cell"
            let pokemonCell = searchListTableView.cells[pokemonCellID]
            
            while !pokemonCell.waitForExistence(timeout: 0.3) {
                app.swipeUp()
            }
            
            if !pokemonCell.isHittable {
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
            searchTabBarButton.tap(withNumberOfTaps: 2, numberOfTouches: 1)
            
        }
        
        return true
    }
    
    private func favoriteAllPokemonFlow(with list: [String]) throws -> Bool {
        searchTabBarButton.tap()
        if !searchTabBarButton.isSelected {
            throw NationalGalarPokedexUITestsError.favoriteAllPokemonFlowError
        }
        
        for name in list {
            let pokemonCell = searchListTableView.cells["\(name)Cell"]
            
            while !pokemonCell.waitForExistence(timeout: 1) {
                app.swipeUp()
            }
            
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
    
    private func navigateToLeagueCardView() throws -> Bool {
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
    
    private func leagueCardViewCellTapped(with cell: String) throws -> Bool {
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
    private func addLeagueCardFlow() throws -> Bool {
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
    
    private func AddLeagueCardResetButtonFlow() throws -> Bool{
        let resetButton = app.buttons["Reset"]
        if !resetButton.isHittable {
            throw NationalGalarPokedexUITestsError.AddLeagueCardResetButtonFlowError
        }
        resetButton.tap()
        return true
    }
        
    private func searchPokemonSearchBarTappedFlow() throws -> Bool {
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
    
    private func searchBarSearchForPokemonFlow(with pokemon: String, searchString: String) throws -> Bool {
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
