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
        XCTAssertNotNil(nationalPokemon)
        XCTAssertNotNil(galarPokemon)
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
        XCTAssert(searchListTableViewController.isHittable)
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
    
    func testNationalPokemonInTableViewIsHittable() {
        XCTAssertNoThrow(try navigateToNationalPokemonTableViewList(), "navigateToNationalPokemonTableViewList Error")
        XCTAssertNoThrow(try viewSearchListTableViewNationalPokemon(with: nationalPokemon), "viewSearchListTableViewNationalPokemon Error")
    }
    
    func testGalarPokemonInTableViewIsHittable() {
        XCTAssertNoThrow(try navigateToGalarPokemonTableViewList(), "navigateToGalarPokemonTableViewList Error")
        XCTAssertNoThrow(try viewSearchListTableViewGalarPokemon(with: galarPokemon), "viewSearchListTableViewGalarPokemon Error")
    }
    
    /// pressing the right bar button will show search bar if not present,  remove if present
    func testRightBarButtonItemMagnifyingglassPressed() {
        XCTAssertNoThrow(try searchPokemonSearchBarTappedFlow(), "searchPokemonSearchBarTappedFlow Error")
        rightBarButtonItemMagnifyingglass.tap()
        XCTAssertFalse(searchPokemonSearchBar.waitForExistence(timeout: 1))
    }
        
    /// Use the searchbar to search National pokemon
    func testSearchForNatioanlPokemon() {
        XCTAssertNoThrow(try navigateToNationalPokemonTableViewList(), "navigateToNationalPokemonTableViewList")
        XCTAssertNoThrow(try searchBarSearchForNationalPokemon(with: nationalPokemon), "searchForNationalPokemonFlow Error")
    }

    /// Use the searchbar to search galar pokemon
    func testSearchForGalarPokemon() {
        XCTAssertNoThrow(try navigateToGalarPokemonTableViewList(), "navigateToGalarPokemonTableViewList Error")
        XCTAssertNoThrow(try searchBarSearchForGalarPokemon(with: galarPokemon), "searchForNationalPokemonFlow Error")
    }
    
    func _testAllNationalPokemonIsHittable() {
        XCTAssertNoThrow(try navigateToNationalPokemonTableViewList(), "navigateToNationalPokemonTableViewList")

        for pokemon in NationalPokemonNames.allCases {
            XCTAssertNoThrow(try nationalPokemonisHittable(with: pokemon))
        }
    }

    func _testAllGalarPokemonIsHittable() {
        XCTAssertNoThrow(try navigateToGalarPokemonTableViewList(), "navigateToGalarPokemonTableViewList Error")

        for pokemon in GalarPokemonNames.allCases {
            XCTAssertNoThrow(try galarPokemonisHittable(with: pokemon))
        }
    }
}

// MARK: - Favorite View Test
extension NationalGalarPokedexUITests{
    func testSearchViewFavorites() {
        searchTabBarButton.tap()
        XCTAssert(searchTabBarButton.isSelected)

        let pokemonCell = searchListTableViewController.cells["\(nationalPokemon.rawValue)Cell"]
        
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
        XCTAssertNoThrow(try favoriteSearchListTableViewNationalPokemon(with: nationalPokemon), "favoriteAllPokemonFlow Error")
    }
    
    func testGalarPokokemonIsFavorite() {
        XCTAssertNoThrow(try navigateToGalarPokemonTableViewList(), "navigateToGalarPokemonTableViewList Error")
        XCTAssertNoThrow(try favoriteSearchListTableViewGalarPokemon(with: galarPokemon), "favoriteAllPokemonFlow Error")
    }
}

// MARK: - LEAGUE CARDS VIEW Test
extension NationalGalarPokedexUITests{
    func testLeagueCardView() {
        XCTAssertNoThrow(try navigateToLeagueCardView(), "navigateToLeagueCardView Error")
    }
    
    func testLeagueCardViewCellTapped() {
        XCTAssertNoThrow(try navigateToLeagueCardView(), "navigateToLeagueCardView Error")
        XCTAssertNoThrow(try leagueCardViewCellTapped(with: "0000 0000 0000 00"), "leagueCardViewCellTapped Cell")
        XCTAssert(searchTabBarButton.isHittable)
        searchTabBarButton.tap()
        XCTAssert(searchTabBarButton.isSelected)
    }
    
    func testAddLeagueCardIDNoiCloudAccountError() {
        XCTAssertNoThrow(try navigateToLeagueCardView(), "navigateToLeagueCardView Error")
        XCTAssertNoThrow(try addLeagueCardFlow(), "addLeagueCardFlow Error")
        XCTAssert(cardCodeNavBarBackButton.isHittable)
        cardCodeNavBarBackButton.tap()
    }
    
    func testAddLeagueCardIDTextFieldsIsHitable() {
        XCTAssertNoThrow(try navigateToLeagueCardView(), "navigateToLeagueCardView Error")
        XCTAssertNoThrow(try addLeagueCardFlow(), "addLeagueCardFlow Error")
        
        XCTAssert(addLeagueCardIDViewTexdFieldA.isHittable)
        addLeagueCardIDViewTexdFieldA.tap()
        
        XCTAssert(addLeagueCardIDViewTexdFieldB.isHittable)
        addLeagueCardIDViewTexdFieldB.tap()
        
        XCTAssert(addLeagueCardIDViewTexdFieldC.isHittable)
        addLeagueCardIDViewTexdFieldC.tap()
        
        XCTAssert(addLeagueCardIDViewTexdFieldD.isHittable)
        addLeagueCardIDViewTexdFieldD.tap()
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
    
    func testLeagueCardIsCheckMark() {
        XCTAssertNoThrow(try navigateToLeagueCardView(), "navigateToLeagueCardView Error")
        
        let leagueCardCell = leagueCardsTableViewController.cells["0000 0000 0000 00"]
        XCTAssert(leagueCardCell.isHittable)
        
        let checkmarkSquareButton = leagueCardCell.buttons["checkmark.square"]
        XCTAssert(checkmarkSquareButton.isHittable)
        checkmarkSquareButton.tap()
        
        let checkmarkSquareFillButton = leagueCardCell.buttons["checkmark.square.fill"]
        XCTAssert(checkmarkSquareFillButton.isHittable)
        checkmarkSquareFillButton.tap()
    }
}
