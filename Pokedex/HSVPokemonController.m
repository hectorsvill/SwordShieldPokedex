//
//  HSVPokemonController.m
//  Pokedex
//
//  Created by Hector S. Villasano on 4/23/20.
//  Copyright © 2020 s. All rights reserved.
//

#import "HSVPokemonController.h"
#import "HSVPokemon.h"
#import "HSVPokemon+HSVinitWithDictionary.h"
@interface HSVPokemonController()

@property (nonatomic, copy, readonly) NSMutableDictionary<NSNumber*, HSVPokemon*> *internalDictionary;

@end

@implementation HSVPokemonController

- (instancetype)init
{
    if (self = [super init]) {
        _internalDictionary = [[self internalDictionary] mutableCopy];
    }
    return self;
}

- (NSUInteger)pokemonListCount
{
    return [_internalDictionary count];
}

- (HSVPokemon *)pokemonWithIndex:(NSNumber *)index
{
    return [_internalDictionary objectForKey:index];
}

- (void)fetchPokemonData:(void (^)(void))completion
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"PokemonSwordShield" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSArray *dataArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error: nil];

    _internalDictionary = [NSMutableDictionary new];

    for (NSDictionary *dictionary in dataArray) {
        HSVPokemon *pokemon = [[HSVPokemon new] initWithDictionary:dictionary];
        [_internalDictionary addEntriesFromDictionary:@{pokemon.pokemonID : pokemon}];
    }

    return completion();
}

@end
