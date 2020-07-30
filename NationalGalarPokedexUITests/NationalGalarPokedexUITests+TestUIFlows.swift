//
//  NationalGalarPokedexUITests+TestUIFlows.swift
//  NationalGalarPokedexUITests
//
//  Created by Hector Villasano on 7/29/20.
//  Copyright © 2020 s. All rights reserved.
//

import XCTest


// MARK: - UI Flows
extension NationalGalarPokedexUITests {
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
        
        if !leagueCardsTableViewController.isHittable {
            throw NationalGalarPokedexUITestsError.navigateToLeagueCardViewError
        }
        
        return true
    }
    
    func viewSearchListTableViewNationalPokemon(with nationalPokemon: NationalPokemonNames) throws -> Bool {
        guard try viewSearchListTableViewPokemonFlow(with: nationalPokemon.rawValue) else {
            throw NationalGalarPokedexUITestsError.viewSearchListTableViewPokemonFlow
        }
        return true
    }
    
    func viewSearchListTableViewGalarPokemon(with galarPokemon: GalarPokemonNames) throws -> Bool {
        guard try viewSearchListTableViewPokemonFlow(with: galarPokemon.rawValue) else {
            throw NationalGalarPokedexUITestsError.viewSearchListTableViewPokemonFlow
        }
        return true
    }
        
    func favoriteSearchListTableViewNationalPokemon(with nationalPokemon: NationalPokemonNames) throws -> Bool{
        guard try favoriteSearchListTableViewPokemonFlow(with: nationalPokemon.rawValue) else {
            throw NationalGalarPokedexUITestsError.favortiePokemonError
        }
        return true
    }
    
    func favoriteSearchListTableViewGalarPokemon(with galarPokemon: GalarPokemonNames) throws -> Bool{
        guard try favoriteSearchListTableViewPokemonFlow(with: galarPokemon.rawValue) else {
            throw NationalGalarPokedexUITestsError.favortiePokemonError
        }
        return true
    }
    
    func searchBarSearchForNationalPokemon(with nationalPokemon: NationalPokemonNames) throws -> Bool {
        guard try searchBarSearchForPokemonFlow(with: nationalPokemon.rawValue, searchString: String(nationalPokemon.rawValue.prefix(3))) else {
            throw NationalGalarPokedexUITestsError.searchForPokemonFlowError
        }
        return true
    }
           
    func searchBarSearchForGalarPokemon(with galarPokemon: GalarPokemonNames) throws -> Bool {
        guard try searchBarSearchForPokemonFlow(with: galarPokemon.rawValue, searchString: String(galarPokemon.rawValue.prefix(3))) else {
            throw NationalGalarPokedexUITestsError.searchForPokemonFlowError
        }
        return true
    }
    
    func nationalPokemonisHittable(with pokemon: NationalPokemonNames) throws -> Bool {
        guard try testPokemonisHittableFlow(with: pokemon.rawValue) else {
            throw NationalGalarPokedexUITestsError.testPokemonisHittableFlowError
        }
        
        return true
    }
    
    func galarPokemonisHittable(with pokemon: GalarPokemonNames) throws -> Bool{
        guard try testPokemonisHittableFlow(with: pokemon.rawValue) else {
            throw NationalGalarPokedexUITestsError.testPokemonisHittableFlowError
        }
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
    
    func leagueCardViewCellTapped(with cell: String) throws -> Bool {
        let cardCodeCell = leagueCardsTableViewController.cells[cell]
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
    
        guard addLeagueCardIDViewTexdFieldA.isHittable,
            addLeagueCardIDViewTexdFieldB.isHittable,
            addLeagueCardIDViewTexdFieldC.isHittable,
            addLeagueCardIDViewTexdFieldD.isHittable else {
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
}

extension NationalGalarPokedexUITests {
    private func testPokemonisHittableFlow(with name: String) throws -> Bool {
        let pokemonCell = searchListTableViewController.cells["\(name)Cell"]
        pokemonCell.tap()
        let pokemonDetailView = app.navigationBars["\(name)DetailView"]
        guard pokemonDetailView.isHittable else { throw NationalGalarPokedexUITestsError.testPokemonisHittableFlowError }
        let backButton = pokemonDetailView.buttons["⚔️🛡Pokedex"]
        guard backButton.waitForExistence(timeout: 1) else { throw NationalGalarPokedexUITestsError.testPokemonisHittableFlowError }
        backButton.tap()
        guard pokemonCell.isHittable else { throw NationalGalarPokedexUITestsError.testPokemonisHittableFlowError }
        return true
    }
    
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
    
    private func viewSearchListTableViewPokemonFlow(with name: String) throws -> Bool {
        if !searchTabBarButton.isHittable {
            throw NationalGalarPokedexUITestsError.viewSearchListTableViewPokemonFlow
        }
        searchTabBarButton.tap()
        
        if !searchTabBarButton.isSelected {
            throw NationalGalarPokedexUITestsError.viewSearchListTableViewPokemonFlow
        }
        
        let pokemonCellID = "\(name)Cell"
        let pokemonCell = searchListTableViewController.cells[pokemonCellID]
        
        while !pokemonCell.waitForExistence(timeout: 0.3) {
            app.swipeUp()
        }
        
        if !pokemonCell.isHittable {
            throw NationalGalarPokedexUITestsError.viewSearchListTableViewPokemonFlow
        }
        searchListTableViewController.cells[pokemonCellID].tap()
        
        XCTAssertNoThrow(try pokemonDetailViewFlow(name: name), "pokemonDetailViewFlow")
        
        if !searchTabBarButton.isHittable {
            throw NationalGalarPokedexUITestsError.viewSearchListTableViewPokemonFlow
        }
        searchTabBarButton.tap()
        
        if !searchNavigationBar.isHittable {
            throw NationalGalarPokedexUITestsError.viewSearchListTableViewPokemonFlow
        }
        return true
    }
    
    private func favoriteSearchListTableViewPokemonFlow(with name: String) throws -> Bool {
        searchTabBarButton.tap()
        if !searchTabBarButton.isSelected {
            throw NationalGalarPokedexUITestsError.favoriteAllPokemonFlowError
        }
        
        let pokemonCell = searchListTableViewController.cells["\(name)Cell"]
        
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
        return true
    }
    
    private func searchBarSearchForPokemonFlow(with pokemon: String, searchString: String) throws -> Bool {
        guard try searchPokemonSearchBarTappedFlow() else { throw NationalGalarPokedexUITestsError.searchForPokemonFlowError }
        
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
        
        let pokemonCell = searchListTableViewController.cells["\(pokemon)Cell"]
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
