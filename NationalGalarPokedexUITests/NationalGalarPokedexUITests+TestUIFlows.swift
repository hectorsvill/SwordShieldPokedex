//
//  NationalGalarPokedexUITests+TestUIFlows.swift
//  NationalGalarPokedexUITests
//
//  Created by Hector Villasano on 7/29/20.
//  Copyright © 2020 s. All rights reserved.
//

import XCTest

extension NationalGalarPokedexUITests {
    func navigateToNationalPokemonTableViewList() throws -> Bool {
        guard searchTabBarButton.isHittable else {
            throw NationalGalarPokedexUITestsError.navigateToNationalPokemonTableViewListError
        }
        
        searchTabBarButton.tap()
        
        guard leftBarButtonItemGear.isHittable else {
            throw NationalGalarPokedexUITestsError.navigateToNationalPokemonTableViewListError
        }
        
        leftBarButtonItemGear.tap()
        
        guard pokedexNOSheet.isHittable else {
            throw NationalGalarPokedexUITestsError.navigateToNationalPokemonTableViewListError
        }
        
        pokedexNOSheetButtons[0].tap()
        
        return true
    }
    
    func navigateToGalarPokemonTableViewList() throws -> Bool {
        guard searchTabBarButton.isHittable else {
            throw NationalGalarPokedexUITestsError.navigateToNationalPokemonTableViewListError
        }
        
        searchTabBarButton.tap()
        
        guard leftBarButtonItemGear.isHittable else {
            throw NationalGalarPokedexUITestsError.navigateToNationalPokemonTableViewListError
        }
        
        leftBarButtonItemGear.tap()
        
        guard pokedexNOSheet.isHittable else {
            throw NationalGalarPokedexUITestsError.navigateToNationalPokemonTableViewListError
        }
        
        pokedexNOSheetButtons[1].tap()
        
        return true
    }
    
    func navigateToLeagueCardView() throws -> Bool {
        guard leagueCardTabBarButton.isHittable else {
            throw NationalGalarPokedexUITestsError.navigateToLeagueCardViewError
        }
        
        leagueCardTabBarButton.tap()
        
        guard leagueCardTabBarButton.isSelected, leagueCardsTableViewController.isHittable else {
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
        let searchString = String(nationalPokemon.rawValue.prefix(3))
        
        guard try searchBarSearchForPokemonFlow(with: nationalPokemon.rawValue, searchString: searchString) else {
            throw NationalGalarPokedexUITestsError.searchForPokemonFlowError
        }
        
        return true
    }
           
    func searchBarSearchForGalarPokemon(with galarPokemon: GalarPokemonNames) throws -> Bool {
        let searchString = String(galarPokemon.rawValue.prefix(3))
        
        guard try searchBarSearchForPokemonFlow(with: galarPokemon.rawValue, searchString: searchString) else {
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
        
        guard searchTabBarButton.isSelected,
            rightBarButtonItemMagnifyingglass.isHittable,
            !searchPokemonSearchBar.waitForExistence(timeout: 1) else {
            throw NationalGalarPokedexUITestsError.searchPokemonSearchBarTappedFlowError
        }
        
        rightBarButtonItemMagnifyingglass.tap()
        
        guard searchPokemonSearchBar.isHittable else {
            throw NationalGalarPokedexUITestsError.searchPokemonSearchBarTappedFlowError
        }
        
        searchPokemonSearchBar.tap()
        
        return true
    }
    
    func leagueCardViewCellTapped(with id: String) throws -> Bool {
        let cardCodeCell = leagueCardsTableViewController.cells[id]
        
        guard cardCodeCell.isHittable else {
            throw NationalGalarPokedexUITestsError.leagueCardViewCellTappedError
        }
        
        cardCodeCell.tap()
        
        guard try leagueCardViewCellTappedFlow(with: id) else {
            throw NationalGalarPokedexUITestsError.leagueCardViewCellTappedError
        }
        
        return true
    }
    
    /// Will click on add league card button to navigate to add league card view. Also works with Account.
    func addLeagueCardFlow() throws -> Bool {
        let leagueCardNavBar = app.navigationBars["League Cards"]
        let errorAlert = app.alerts["iCloud Error"]
        
        guard leagueCardNavBar.isHittable else {
            throw NationalGalarPokedexUITestsError.addLeagueCardFlowError
        }
        
        leagueCardNavBar.buttons["plus"].tap()
                
        if errorAlert.waitForExistence(timeout: 1) {
            guard errorAlert.isHittable else {
                throw NationalGalarPokedexUITestsError.addLeagueCardFlowError
            }
            
            let alertOkButton = errorAlert.buttons["OK"]
            
            guard alertOkButton.isHittable else {
                throw NationalGalarPokedexUITestsError.addLeagueCardFlowError
            }
            
            alertOkButton.tap()
        }
        
        return true
    }
    
    func AddLeagueCardResetButtonFlow() throws -> Bool{
        let resetButton = app.buttons["Reset"]
        
        guard resetButton.isHittable else {
            throw NationalGalarPokedexUITestsError.AddLeagueCardResetButtonFlowError
        }
        
        resetButton.tap()
        
        return true
    }
}


// MARK: - UI Flows
extension NationalGalarPokedexUITests {
    private func testPokemonisHittableFlow(with name: String) throws -> Bool {
        let pokemonCell = searchListTableViewController.cells["\(name)Cell"]
        let pokemonDetailView = app.navigationBars["\(name)DetailView"]
        let backButton = pokemonDetailView.buttons["⚔️🛡Pokedex"]
        
        pokemonCell.tap()
        
        guard pokemonDetailView.isHittable,
            backButton.waitForExistence(timeout: 1) else {
            throw NationalGalarPokedexUITestsError.testPokemonisHittableFlowError
        }
        
        backButton.tap()
        
        guard pokemonCell.isHittable else {
            throw NationalGalarPokedexUITestsError.testPokemonisHittableFlowError
        }
        
        return true
    }
    
    private func pokemonDetailViewFlow(name: String, enableDetailViewSections: Bool = false, enableAudio: Bool = false) throws -> Bool {
        let detailViewSections = ["Description", "NO.", "Type", "Height & Weight", "Base Stats", "Hatch Cycles", "Exp Group", "Egg groups", "Egg Moves", "Abilities", "Level Up Moves"]
        let pokemonDetailViewNaviationBar = app.navigationBars["\(name)DetailView"]
        let playPauseButton = app.buttons["playpause"]
        let serebiiButton = pokemonDetailViewNaviationBar.buttons["serebii.net"]
        
        guard pokemonDetailViewNaviationBar.isHittable,
            playPauseButton.isHittable else {
            throw NationalGalarPokedexUITestsError.pokemonDetailViewFlowError
        }
        
        if enableAudio {
            playPauseButton.tap()
        }
        
        if enableDetailViewSections {
            for section in detailViewSections {
                let button = app.tables.buttons[section]
                
                guard button.isHittable else {
                    throw NationalGalarPokedexUITestsError.pokemonDetailViewFlowError
                }
                
                button.tap()
            }
        }
        
        guard serebiiButton.isHittable else {
            throw NationalGalarPokedexUITestsError.pokemonDetailViewFlowError
        }
        
        serebiiButton.tap()
        pokemonDetailViewNaviationBar.buttons["\(name)"].tap()
        
        return true
    }
    
    private func viewSearchListTableViewPokemonFlow(with name: String) throws -> Bool {
        let pokemonCellID = "\(name)Cell"
        let pokemonCell = searchListTableViewController.cells[pokemonCellID]
        
        guard searchTabBarButton.isHittable else {
            throw NationalGalarPokedexUITestsError.viewSearchListTableViewPokemonFlow
        }
        
        searchTabBarButton.tap()
        
        guard searchTabBarButton.isSelected else {
            throw NationalGalarPokedexUITestsError.viewSearchListTableViewPokemonFlow
        }
        
        while !pokemonCell.waitForExistence(timeout: 0.3) {
            app.swipeUp()
        }
        
        guard pokemonCell.isHittable else {
            throw NationalGalarPokedexUITestsError.viewSearchListTableViewPokemonFlow
        }
        
        searchListTableViewController.cells[pokemonCellID].tap()
        
        guard try pokemonDetailViewFlow(name: name),
            searchTabBarButton.isHittable  else {
            throw NationalGalarPokedexUITestsError.viewSearchListTableViewPokemonFlow
        }
        
        searchTabBarButton.tap()
        
        guard searchNavigationBar.isHittable else {
            throw NationalGalarPokedexUITestsError.viewSearchListTableViewPokemonFlow
        }
        
        return true
    }
    
    private func favoriteSearchListTableViewPokemonFlow(with name: String) throws -> Bool {
        let pokemonCell = searchListTableViewController.cells["\(name)Cell"]
        let cellHeartButton = pokemonCell.buttons["heart"]
        let collectionViewPokemonCell = app.collectionViews.cells["\(name)Cell"]
        let cellHeartFillButton = pokemonCell.buttons["heart.fill"]
        
        searchTabBarButton.tap()
        
        guard searchTabBarButton.isSelected else {
            throw NationalGalarPokedexUITestsError.favoriteAllPokemonFlowError
        }
                
        while !pokemonCell.waitForExistence(timeout: 1) {
            app.swipeUp()
        }
        
        guard pokemonCell.isHittable else {
            throw NationalGalarPokedexUITestsError.favoriteAllPokemonFlowError
        }
        
        
        if !cellHeartButton.isHittable {
            app.swipeUp()
        }
        
        cellHeartButton.tap()
        
        guard favoritesTabBarButton.isHittable else {
            throw NationalGalarPokedexUITestsError.favoriteAllPokemonFlowError
        }
        
        favoritesTabBarButton.tap()
        
        guard favoritesTabBarButton.isSelected,
            collectionViewPokemonCell.isHittable else {
            throw NationalGalarPokedexUITestsError.favoriteAllPokemonFlowError
        }
        
        collectionViewPokemonCell.tap()
        
        guard try pokemonDetailViewFlow(name: name) else {
            throw NationalGalarPokedexUITestsError.favoriteAllPokemonFlowError
        }
        
        favoritesTabBarButton.tap()
        
        guard favoritesTabBarButton.isSelected,
            searchTabBarButton.isHittable else {
            throw NationalGalarPokedexUITestsError.favoriteAllPokemonFlowError
        }
        
        searchTabBarButton.tap()
        
        guard searchTabBarButton.isSelected,
            cellHeartFillButton.isHittable else {
            throw NationalGalarPokedexUITestsError.favoriteAllPokemonFlowError
        }
        
        cellHeartFillButton.tap()
        
        return true
    }
    
    private func searchBarSearchForPokemonFlow(with pokemon: String, searchString: String) throws -> Bool {
        let pokemonCell = searchListTableViewController.cells["\(pokemon)Cell"]
        let pokemonDetailNavigationBar = app.navigationBars["\(pokemon)DetailView"]
        
        guard try searchPokemonSearchBarTappedFlow(),
            searchPokemonSearchBar.isHittable else {
            throw NationalGalarPokedexUITestsError.searchForPokemonFlowError
        }
        
        searchPokemonSearchBar.tap()
        
        searchString.forEach {
            app.keys[String($0)].tap()
        }
        
        guard rightBarButtonItemMagnifyingglass.isHittable else {
            throw NationalGalarPokedexUITestsError.searchPokemonSearchBarTappedFlowError
        }
        
        rightBarButtonItemMagnifyingglass.tap()
        
        guard pokemonCell.isHittable else {
            throw NationalGalarPokedexUITestsError.searchPokemonSearchBarTappedFlowError
        }
        
        pokemonCell.tap()
        
        guard pokemonDetailNavigationBar.isHittable,
            try pokemonDetailViewFlow(name: pokemon, enableDetailViewSections: true, enableAudio: true)  else {
            throw NationalGalarPokedexUITestsError.searchPokemonSearchBarTappedFlowError
        }

        pokemonDetailNavigationBar.buttons["⚔️🛡Pokedex"].tap()

        return true
    }
    
    private func addLeagueCardIDViewTexdFieldAIsHittable() throws -> Bool {
        guard app.textFields.count == 4,
            addLeagueCardIDViewTexdFieldA.isHittable,
            addLeagueCardIDViewTexdFieldB.isHittable,
            addLeagueCardIDViewTexdFieldC.isHittable,
            addLeagueCardIDViewTexdFieldD.isHittable else {
                throw NationalGalarPokedexUITestsError.addLeagueCardIDViewTexdFieldAIsHittableError
        }
        
        return true
    }
    
    private func leagueCardViewCellTappedFlow(with id: String) throws -> Bool {
        let myCardCodeNavBar = app.navigationBars["My Card Code"]
        let myCardCodeNavBarInfoButton = myCardCodeNavBar.buttons["info.circle"]
        let serebiiView = app.navigationBars["HSVSerebiiView"]
        let backButton = serebiiView.buttons["My Card Code"]
        
        guard myCardCodeNavBar.isHittable,
            try addLeagueCardIDViewTexdFieldAIsHittable(),
            myCardCodeNavBarInfoButton.isHittable  else {
            throw NationalGalarPokedexUITestsError.leagueCardViewCellTappedFlowError
        }
        
        myCardCodeNavBarInfoButton.tap()
        
        guard serebiiView.isHittable,
            backButton.isHittable else {
            throw NationalGalarPokedexUITestsError.leagueCardViewCellTappedFlowError
        }
        
        backButton.tap()
        
        guard cardCodeNavBarBackButton.isHittable else {
            throw NationalGalarPokedexUITestsError.leagueCardViewCellTappedFlowError
        }
        
        cardCodeNavBarBackButton.tap()
        
        return true
    }
    
}
