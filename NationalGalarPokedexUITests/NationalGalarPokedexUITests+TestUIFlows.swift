//
//  NationalGalarPokedexUITests+TestUIFlows.swift
//  NationalGalarPokedexUITests
//
//  Created by Hector Villasano on 7/29/20.
//  Copyright © 2020 s. All rights reserved.
//

import XCTest

extension NationalGalarPokedexUITests {
    func navigateToNationalPokemonTableViewList() throws {
        XCTAssert(searchTabBarButton.isHittable)
        
        searchTabBarButton.tap()
        
        XCTAssert(leftBarButtonItemGear.isHittable)
        
        leftBarButtonItemGear.tap()
        
        XCTAssert(pokedexNOSheet.isHittable)
        
        pokedexNOSheetButtons[0].tap()
    }
    
    func navigateToGalarPokemonTableViewList() throws {
        XCTAssert(searchTabBarButton.isHittable)
        
        searchTabBarButton.tap()
        
        XCTAssert(leftBarButtonItemGear.isHittable)
        
        leftBarButtonItemGear.tap()
        
        XCTAssert(pokedexNOSheet.isHittable)
        
        pokedexNOSheetButtons[1].tap()
    }
    
    func navigateToLeagueCardView() throws{
        XCTAssert(leagueCardTabBarButton.isHittable)
        
        leagueCardTabBarButton.tap()
        
        XCTAssert(leagueCardTabBarButton.isSelected)
        XCTAssert(leagueCardsTableViewController.isHittable)
    }
    
    func viewSearchListTableViewNationalPokemon(with nationalPokemon: NationalPokemonNames) throws {
        try viewSearchListTableViewPokemonFlow(with: nationalPokemon.rawValue)
    }
    
    func viewSearchListTableViewGalarPokemon(with galarPokemon: GalarPokemonNames) throws{
        try viewSearchListTableViewPokemonFlow(with: galarPokemon.rawValue)
    }
        
    func favoriteSearchListTableViewNationalPokemon(with nationalPokemon: NationalPokemonNames) throws {
        try favoriteSearchListTableViewPokemonFlow(with: nationalPokemon.rawValue)
    }
    
    func favoriteSearchListTableViewGalarPokemon(with galarPokemon: GalarPokemonNames) throws {
        try favoriteSearchListTableViewPokemonFlow(with: galarPokemon.rawValue)
    }
    
    func searchBarSearchForNationalPokemon(with nationalPokemon: NationalPokemonNames) throws {
        let searchString = String(nationalPokemon.rawValue.prefix(3))
        try searchBarSearchForPokemonFlow(with: nationalPokemon.rawValue, searchString: searchString)
    }
           
    func searchBarSearchForGalarPokemon(with galarPokemon: GalarPokemonNames) throws {
        let searchString = String(galarPokemon.rawValue.prefix(3))
        try searchBarSearchForPokemonFlow(with: galarPokemon.rawValue, searchString: searchString)
    }
    
    func nationalPokemonisHittable(with pokemon: NationalPokemonNames) throws {
        try testPokemonisHittableFlow(with: pokemon.rawValue)
    }
    
    func galarPokemonisHittable(with pokemon: GalarPokemonNames) throws {
        try testPokemonisHittableFlow(with: pokemon.rawValue)
    }
    
    func searchPokemonSearchBarTappedFlow() throws {
        searchTabBarButton.tap()
        
        XCTAssert( searchTabBarButton.isSelected)
        XCTAssert(rightBarButtonItemMagnifyingglass.isHittable)
        XCTAssertFalse(searchPokemonSearchBar.waitForExistence(timeout: 1))
        
        rightBarButtonItemMagnifyingglass.tap()
        
        XCTAssert(searchPokemonSearchBar.isHittable)
        
        searchPokemonSearchBar.tap()
    }
    
    func leagueCardViewCellTapped(with id: LeagueCardID) throws {
        let cardCodeCell = leagueCardsTableViewController.cells[id.rawValue]
        XCTAssert(cardCodeCell.isHittable)
        
        cardCodeCell.tap()
        
        try leagueCardViewCellTappedFlow()
    }
    
    /// Will click on add league card button to navigate to add league card view. Also works with Account.
    func addLeagueCardFlow() throws {
        let leagueCardNavBar = app.navigationBars["League Cards"]
        let errorAlert = app.alerts["iCloud Error"]
        
        XCTAssert(leagueCardNavBar.isHittable)
        
        leagueCardNavBar.buttons["plus"].tap()
                
        if errorAlert.waitForExistence(timeout: 1) {
            XCTAssert(errorAlert.isHittable)
            let alertOkButton = errorAlert.buttons["OK"]
            XCTAssert(alertOkButton.isHittable)
            
            alertOkButton.tap()
        }
    }
    
    func AddLeagueCardResetButtonFlow() throws {
        let resetButton = app.buttons["Reset"]
        XCTAssert(resetButton.isHittable)
        
        resetButton.tap()
    }
    
    func leagueCardIsCheckMark(with id: LeagueCardID) throws {
        XCTAssertNoThrow(try navigateToLeagueCardView(), "navigateToLeagueCardView Error")
        
        let leagueCardCell = leagueCardsTableViewController.cells[id.rawValue]
        XCTAssert(leagueCardCell.isHittable)
        
        let checkmarkSquareButton = leagueCardCell.buttons["checkmark.square"]
        XCTAssert(checkmarkSquareButton.isHittable)
        checkmarkSquareButton.tap()
        
        let checkmarkSquareFillButton = leagueCardCell.buttons["checkmark.square.fill"]
        XCTAssert(checkmarkSquareFillButton.isHittable)
        checkmarkSquareFillButton.tap()
    }
}


// MARK: - UI Flows
extension NationalGalarPokedexUITests {
    private func testPokemonisHittableFlow(with name: String) throws {
        let pokemonCell = searchListTableViewController.cells["\(name)Cell"]
        let pokemonDetailView = app.navigationBars["\(name)DetailView"]
        let backButton = pokemonDetailView.buttons["⚔️🛡Pokedex"]
        
        pokemonCell.tap()
        
        XCTAssert(pokemonDetailView.isHittable)
        XCTAssert(backButton.waitForExistence(timeout: 1))
        
        backButton.tap()
        
        XCTAssert(pokemonCell.isHittable)
    }
    
    private func pokemonDetailViewFlow(name: String, enableDetailViewSections: Bool = false, enableAudio: Bool = false) throws {
        let detailViewSections = ["Description", "NO.", "Type", "Height & Weight", "Base Stats", "Hatch Cycles", "Exp Group", "Egg groups", "Egg Moves", "Abilities", "Level Up Moves"]
        let pokemonDetailViewNaviationBar = app.navigationBars["\(name)DetailView"]
        let playPauseButton = app.buttons["playpause"]
        let serebiiButton = pokemonDetailViewNaviationBar.buttons["serebii.net"]
        
        XCTAssert(pokemonDetailViewNaviationBar.isHittable)
        XCTAssert(playPauseButton.isHittable)
        
        if enableAudio {
            playPauseButton.tap()
        }
        
        if enableDetailViewSections {
            for section in detailViewSections {
                let button = app.tables.buttons[section]
                if button.waitForExistence(timeout: 0.1) {
                    XCTAssert(button.isHittable)
                    button.tap()
                }
                
            }
        }
        
        XCTAssert(serebiiButton.isHittable)
        
        serebiiButton.tap()
        pokemonDetailViewNaviationBar.buttons["\(name)"].tap()
    }
    
    private func viewSearchListTableViewPokemonFlow(with name: String) throws {
        let pokemonCellID = "\(name)Cell"
        let pokemonCell = searchListTableViewController.cells[pokemonCellID]
        
        XCTAssert(searchTabBarButton.isHittable)
        
        searchTabBarButton.tap()
        
        XCTAssert(searchTabBarButton.isSelected)
        
        while !pokemonCell.waitForExistence(timeout: 0.3) {
            app.swipeUp()
        }
        
        XCTAssert(pokemonCell.isHittable)
        
        searchListTableViewController.cells[pokemonCellID].tap()
        
        try pokemonDetailViewFlow(name: name)
        XCTAssert(searchTabBarButton.isHittable)
        
        searchTabBarButton.tap()
        
        XCTAssert(searchNavigationBar.isHittable)
    }
    
    private func favoriteSearchListTableViewPokemonFlow(with name: String) throws {
        let pokemonCell = searchListTableViewController.cells["\(name)Cell"]
        let cellHeartButton = pokemonCell.buttons["heart"]
        let collectionViewPokemonCell = app.collectionViews.cells["\(name)Cell"]
        let cellHeartFillButton = pokemonCell.buttons["heart.fill"]
        
        searchTabBarButton.tap()
        
        XCTAssert(searchTabBarButton.isSelected)
                
        while !pokemonCell.waitForExistence(timeout: 1) {
            app.swipeUp()
        }
        
        XCTAssert(pokemonCell.isHittable)
        
        
        if !cellHeartButton.isHittable {
            app.swipeUp()
        }
        
        cellHeartButton.tap()
        
        XCTAssert(favoritesTabBarButton.isHittable)
        
        favoritesTabBarButton.tap()
        
        XCTAssert(favoritesTabBarButton.isSelected)
        XCTAssert(collectionViewPokemonCell.isHittable)
        
        collectionViewPokemonCell.tap()
        
        try pokemonDetailViewFlow(name: name)
        
        favoritesTabBarButton.tap()
        
        XCTAssert(favoritesTabBarButton.isSelected)
        XCTAssert(searchTabBarButton.isHittable)
        
        searchTabBarButton.tap()
        
        XCTAssert(searchTabBarButton.isSelected)
        XCTAssert(cellHeartFillButton.isHittable)
        
        cellHeartFillButton.tap()
    }
    
    private func searchBarSearchForPokemonFlow(with pokemon: String, searchString: String) throws {
        let pokemonCell = searchListTableViewController.cells["\(pokemon)Cell"]
        let pokemonDetailNavigationBar = app.navigationBars["\(pokemon)DetailView"]
        
        try searchPokemonSearchBarTappedFlow()
        XCTAssert(searchPokemonSearchBar.isHittable)
        
        searchPokemonSearchBar.tap()
        
        searchString.forEach {
            app.keys[String($0)].tap()
        }
        
        XCTAssert(rightBarButtonItemMagnifyingglass.isHittable)
        
        rightBarButtonItemMagnifyingglass.tap()
        
        XCTAssert(pokemonCell.isHittable)
        
        pokemonCell.tap()
        
        XCTAssert(pokemonDetailNavigationBar.isHittable)
        try pokemonDetailViewFlow(name: pokemon, enableDetailViewSections: true, enableAudio: true)

        pokemonDetailNavigationBar.buttons["⚔️🛡Pokedex"].tap()
    }
    
    private func addLeagueCardIDViewTexdFieldAIsHittable() throws {
        XCTAssert(app.textFields.count == 4)
        XCTAssert(addLeagueCardIDViewTexdFieldA.isHittable)
        XCTAssert(addLeagueCardIDViewTexdFieldB.isHittable)
        XCTAssert(addLeagueCardIDViewTexdFieldC.isHittable)
        XCTAssert(addLeagueCardIDViewTexdFieldD.isHittable)
    }
    
    private func leagueCardViewCellTappedFlow() throws {
        let myCardCodeNavBar = app.navigationBars["My Card Code"]
        let myCardCodeNavBarInfoButton = myCardCodeNavBar.buttons["info.circle"]
        let serebiiView = app.navigationBars["HSVSerebiiView"]
        let backButton = serebiiView.buttons["My Card Code"]
        
        XCTAssert(myCardCodeNavBar.isHittable)
        try addLeagueCardIDViewTexdFieldAIsHittable()
        XCTAssert(myCardCodeNavBarInfoButton.isHittable)
        
        myCardCodeNavBarInfoButton.tap()
        
        XCTAssert(serebiiView.isHittable)
        XCTAssert(backButton.isHittable)
            
        backButton.tap()
        
        XCTAssert(cardCodeNavBarBackButton.isHittable)
        
        cardCodeNavBarBackButton.tap()
    }
}
