//
//  NationalGalarPokedexUITestsMocData.swift
//  NationalGalarPokedexUITests
//
//  Created by Hector Villasano on 7/24/20.
//  Copyright © 2020 s. All rights reserved.
//

import Foundation


class NationalGalarPokedexUITestsMocData {
    private (set) var nationalPokemonNames: [NationalPokemonNames]
    private (set) var galarPokemonNames: [GalarPokemonNames]
    
    init(nationalPokemonNames: [NationalPokemonNames], galarPokemonNames: [GalarPokemonNames]) {
        self.nationalPokemonNames = nationalPokemonNames
        self.galarPokemonNames = galarPokemonNames
    }
    
    func setNationalPokemonNames(with nationalPokemonNames: [NationalPokemonNames]) {
        self.nationalPokemonNames = nationalPokemonNames
    }
    
    func setGalarPokemonNames(with galarPokemonNames: [GalarPokemonNames]) {
        self.galarPokemonNames = galarPokemonNames
    }
}

