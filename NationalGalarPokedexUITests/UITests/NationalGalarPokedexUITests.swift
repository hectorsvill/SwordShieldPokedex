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
    var nationalPokemon: NationalPokemonNames! = nil
    var galarPokemon: GalarPokemonNames! = nil
    
    override func setUpWithError() throws {
        nationalPokemon = .Bulbasaur
        galarPokemon = .Raboot
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["enable-testing"]
        app.launch()
    }

    override func tearDownWithError() throws {
        app.terminate()
    }
}
