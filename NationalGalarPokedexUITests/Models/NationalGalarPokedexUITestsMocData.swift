//
//  NationalGalarPokedexUITestsMocData.swift
//  NationalGalarPokedexUITests
//
//  Created by Hector Villasano on 7/24/20.
//  Copyright © 2020 s. All rights reserved.
//

import Foundation


class NationalGalarPokedexUITestsMocData {
    private (set) var nationalPokemonNames: NationalPokemonNames
    private (set) var galarPokemonNames: GalarPokemonNames
    
    init(nationalPokemonName: NationalPokemonNames, galarPokemonName: GalarPokemonNames) {
        self.nationalPokemonNames = nationalPokemonName
        self.galarPokemonNames = galarPokemonName
    }
    
    func setNationalPokemonName(with nationalPokemonNames: NationalPokemonNames) {
        self.nationalPokemonNames = nationalPokemonNames
    }
    
    func setGalarPokemonName(with galarPokemonNames: GalarPokemonNames) {
        self.galarPokemonNames = galarPokemonNames
    }
}

