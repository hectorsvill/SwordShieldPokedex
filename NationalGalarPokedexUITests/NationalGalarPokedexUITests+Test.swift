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
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                app.launch()
            }
        }
    }
    
    func testAddMobBannerIsHittable() throws {
        XCTAssert(googleMobileAddsBannerView.isHittable)
    }
    
    func testPokemonNameListNotNil() throws {
        XCTAssertNotNil(nationalPokemon)
        XCTAssertNotNil(galarPokemon)
    }
    
    func testRightBarButtonItemMagnifyingglassISHittable() throws {
        XCTAssert(rightBarButtonItemMagnifyingglass.isHittable)
        rightBarButtonItemMagnifyingglass.tap()
    }
    
    func testLeftBarButtonItemGearISHittable() throws {
        XCTAssert(leftBarButtonItemGear.isHittable)
        leftBarButtonItemGear.tap()
    }
    
    func testPokedexSearchNavigationBarIsHittable() throws {
        XCTAssert(searchNavigationBar.isHittable)
    }
    
    func testpokedexListTableViewIsHittable() throws {
        XCTAssert(searchListTableViewController.isHittable)
    }
    
    func testTabBarButtonsIsHittable() throws {
        XCTAssert(favoritesTabBarButton.isHittable)
        XCTAssert(leagueCardTabBarButton.isHittable)
        XCTAssert(searchTabBarButton.isHittable)
    }
    
    func testPokedexNOSheetButtonsIsHittable() throws {
        for button in pokedexNOSheetButtons {
            leftBarButtonItemGear.tap()
            XCTAssert(button.isHittable)
            button.tap()
        }
    }
    
    func testNavigateTonationalPokemonTableViewList() throws {
        try navigateToNationalPokemonTableViewList()
    }
    
    func testNavigateToGalarPokemonTableViewList() throws {
        try navigateToGalarPokemonTableViewList()
    }
    
    func testNationalPokemonInTableViewIsHittable() throws {
        try navigateToNationalPokemonTableViewList()
        try viewSearchListTableViewNationalPokemon(with: nationalPokemon)
    }
    
    func testGalarPokemonInTableViewIsHittable() throws {
        try navigateToGalarPokemonTableViewList()
        try viewSearchListTableViewGalarPokemon(with: galarPokemon)
    }
    
    /// pressing the right bar button will show search bar if not present,  remove if present
    func testRightBarButtonItemMagnifyingglassPressed() throws {
        try searchPokemonSearchBarTappedFlow()
        
        rightBarButtonItemMagnifyingglass.tap()
        
        XCTAssertFalse(searchPokemonSearchBar.waitForExistence(timeout: 1))
    }
        
    /// Use the searchbar to search National pokemon
    func testSearchForNatioanlPokemon() throws {
        try navigateToNationalPokemonTableViewList()
        try searchBarSearchForNationalPokemon(with: nationalPokemon)
    }

    /// Use the searchbar to search galar pokemon
    func testSearchForGalarPokemon() throws {
        try navigateToGalarPokemonTableViewList()
        try searchBarSearchForGalarPokemon(with: galarPokemon)
    }
    
    func testAllNationalPokemonIsHittable() throws {
        try navigateToNationalPokemonTableViewList()

        for pokemon in NationalPokemonNames.allCases {
             try nationalPokemonisHittable(with: pokemon)
        }
    }

    func testAllGalarPokemonIsHittable() throws {
        try navigateToGalarPokemonTableViewList()

        for pokemon in GalarPokemonNames.allCases {
            try galarPokemonisHittable(with: pokemon)
        }
    }
}

// MARK: - Favorite View Test
extension NationalGalarPokedexUITests{
    func testSearchViewFavorites() throws {
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
    
    func testNationalPokokemonIsFavorite() throws {
        try navigateToNationalPokemonTableViewList()
        try favoriteSearchListTableViewNationalPokemon(with: nationalPokemon)
    }
    
    func testGalarPokokemonIsFavorite() throws {
        try navigateToGalarPokemonTableViewList()
        try favoriteSearchListTableViewGalarPokemon(with: galarPokemon)
    }
}

// MARK: - LEAGUE CARDS VIEW Test
extension NationalGalarPokedexUITests{
    func testLeagueCardView() throws {
        try navigateToLeagueCardView()
    }
    
    func testLeagueCardViewCellTapped() throws {
        try navigateToLeagueCardView()
        try leagueCardViewCellTapped(with: "0000 0000 0000 00")
        XCTAssert(searchTabBarButton.isHittable)
        searchTabBarButton.tap()
        XCTAssert(searchTabBarButton.isSelected)
    }
    
    func testAddLeagueCardIDNoiCloudAccountError() throws {
        try navigateToLeagueCardView()
        try addLeagueCardFlow()
    }
    
    func testAddLeagueCardIDTextFieldsIsHitable() throws {
        try navigateToLeagueCardView()
        try addLeagueCardFlow()

        XCTAssert(addLeagueCardIDViewTexdFieldA.isHittable)
        addLeagueCardIDViewTexdFieldA.tap()

        XCTAssert(addLeagueCardIDViewTexdFieldB.isHittable)
        addLeagueCardIDViewTexdFieldB.tap()

        XCTAssert(addLeagueCardIDViewTexdFieldC.isHittable)
        addLeagueCardIDViewTexdFieldC.tap()

        XCTAssert(addLeagueCardIDViewTexdFieldD.isHittable)
        addLeagueCardIDViewTexdFieldD.tap()
    }
    
    func testAddLeagueCardSubmitEmptyCodeButtonError() throws {
        try navigateToLeagueCardView()
        try addLeagueCardFlow()
        
        let submitButton = app.buttons["Submit"]
        XCTAssert(submitButton.isHittable)
        submitButton.tap()
        
        let alertOKButton = app.alerts["Error"].buttons["OK"]
        XCTAssert(alertOKButton.isHittable)
        alertOKButton.tap()
        
        XCTAssert(cardCodeNavBarBackButton.isHittable)
        cardCodeNavBarBackButton.tap()
    }
    
    func testAddLeagueCardResetButtonisHitable() throws {
        try navigateToLeagueCardView()
        try addLeagueCardFlow()
        try AddLeagueCardResetButtonFlow()
        XCTAssert(cardCodeNavBarBackButton.isHittable)
        cardCodeNavBarBackButton.tap()
    }
    
    func testLeagueCardIsCheckMark() throws {
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
