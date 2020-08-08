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
    let mocData = NationalGalarPokedexUITestsMocData(nationalPokemonName: .Flygon, galarPokemonName: .Carkol)
    var nationalPokemon: NationalPokemonNames! = nil
    var galarPokemon: GalarPokemonNames! = nil
    
    override func setUpWithError() throws {
        nationalPokemon = mocData.nationalPokemonNames
        galarPokemon = mocData.galarPokemonNames
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app.terminate()
    }
}
