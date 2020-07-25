//
//  NationalGalarPokedexUITests+Test.swift
//  NationalGalarPokedexUITests
//
//  Created by Hector Villasano on 7/24/20.
//  Copyright © 2020 s. All rights reserved.
//

import XCTest

extension NationalGalarPokedexUITests {
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
    
    //MARK: - Search View
    
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
        navigateToNationalPokemonTableViewList()
    }
    
    func testNavigateToGalarPokemonTableViewList() {
        navigateToGalarPokemonTableViewList()
    }
    
    func testAllNationalPokemonInTableViewIsHittable() {
        navigateToNationalPokemonTableViewList()
        viewAllPokemonFlow(with: [nationalPokemonNames[0]])
    }
    
    func testAllGalarPokemonInTableViewIsHittable() {
        navigateToGalarPokemonTableViewList()
        viewAllPokemonFlow(with: [galarPokemonNames[0]])
    }
    
    // MARK: - Favorite View
    
    func testSearchViewFavorites() {
        searchTabBarButton.tap()
        XCTAssert(searchTabBarButton.isSelected)

        let cell = searchListTableView.cells["\(nationalPokemonNames[0])Cell"]
        XCTAssert(cell.isHittable)
        
        let cellHeartButton = cell.buttons["heart"]
        XCTAssert(cellHeartButton.isHittable)
        cellHeartButton.tap()

        leftBarButtonItemGear.tap()
        XCTAssert(pokedexNOSheet.isHittable)
        
        let favoriteButton = pokedexNOSheetButtons[2]
        favoriteButton.tap()
        
        XCTAssert(cell.isHittable)
        
        let cellHeartFillButton = cell.buttons["heart.fill"]
        XCTAssertTrue(cellHeartFillButton.isHittable)
        cellHeartFillButton.tap()
        
        let cellExist = cell.waitForExistence(timeout: 1)
        XCTAssertFalse(cellExist)
        
        leftBarButtonItemGear.tap()
        XCTAssert(pokedexNOSheet.isHittable)
        pokedexNOSheetButtons[0].tap()
        XCTAssert(cellHeartButton.isHittable)
    }
    
    func testNationalPokokemonIsFavorite() {
        navigateToNationalPokemonTableViewList()
        favoriteAllPokemonFlow(with: [nationalPokemonNames[2]])
    }
    
    func testGalarPokokemonIsFavorite() {
        navigateToGalarPokemonTableViewList()
        favoriteAllPokemonFlow(with: [galarPokemonNames[1]])
    }
    
    // MARK: - LEAGUE CARDS VIEW
    
    func testLeagueCardView() {
        navigateToLeagueCardView()
    }
    
    func testLeagueCardViewCellTapped() {
        navigateToLeagueCardView()
        leagueCardViewCellTapped(with: "0000 0000 0000 00")
        XCTAssert(searchTabBarButton.isHittable)
        searchTabBarButton.tap()
        XCTAssert(searchTabBarButton.isSelected)
    }
    
    func testAddLeagueCard_NoiCloudAccountError() {
        navigateToLeagueCardView()
        addLeagueCard_NoAccountErrorFlow()
        XCTAssert(cardCodeNavBarBackButton.isHittable)
        cardCodeNavBarBackButton.tap()
    }
    
    func testAddLeagueCard_SubmitEmptyCodeButtonError() {
        navigateToLeagueCardView()
        addLeagueCard_NoAccountErrorFlow()
        
        let submitButton = app.buttons["Submit"]
        XCTAssert(submitButton.isHittable)
        submitButton.tap()
        
        let alertOKButton = app.alerts["Error"].buttons["OK"]
        XCTAssert(alertOKButton.isHittable)
        alertOKButton.tap()
        
        XCTAssert(cardCodeNavBarBackButton.isHittable)
        cardCodeNavBarBackButton.tap()
    }
    
    func testAddLeagueCard_ResetButtonisHitable() {
        navigateToLeagueCardView()
        addLeagueCard_NoAccountErrorFlow()
        AddLeagueCard_ResetButtonFlow()
        XCTAssert(cardCodeNavBarBackButton.isHittable)
        cardCodeNavBarBackButton.tap()
    }
}
