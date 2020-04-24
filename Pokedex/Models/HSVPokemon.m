//
//  HSVPokemon.m
//  Pokedex
//
//  Created by s on 4/22/20.
//  Copyright © 2020 s. All rights reserved.
//

#import "HSVPokemon.h"

@implementation HSVPokemon
- (instancetype)initWithName:(NSString *)name pokemonID:(NSNumber *)pokemonID descriptions:(NSString *)pokemondescription
{
    if (self = [super init]) {
        _name = [name copy];
        pokemondescription = [pokemondescription copy];
        _pokemonID = [pokemonID copy];
    }

    return self;
}
@end
