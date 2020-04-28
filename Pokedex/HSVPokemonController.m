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

@property NSMutableDictionary<NSNumber*, HSVPokemon*> *internalDictionary;
@property NSArray<NSNumber *> *internalPokemonIndexList;
@property NSMutableArray<NSNumber *> *internalFavoritePokemon;

@end

@implementation HSVPokemonController

- (instancetype)init
{
    if (self = [super init]) {
        _internalDictionary = [[self pokemonDictionary] mutableCopy];
        _internalPokemonIndexList = [[self pokemonIndexList] mutableCopy];
        _internalFavoritePokemon = [[self favoritePokemon] mutableCopy];
    }
    return self;
}

- (NSUInteger)pokemonListCount
{
    return [_internalDictionary count];
}

- (HSVPokemon *)fetchpokemonWithIndex:(NSNumber *)index
{
    return [_internalDictionary objectForKey:index];
}

- (NSArray<NSNumber *> *)pokemonIndexList
{
    return _internalPokemonIndexList;
}

- (void)addFavorite:(NSNumber *)number
{
    if (_internalFavoritePokemon == nil) {
        _internalFavoritePokemon = [NSMutableArray new];
    }

    [_internalFavoritePokemon insertObject:number atIndex: 0];
}

- (void)removeInternalFavoritePokemonAtIndexe:(int)index
{
    [_internalFavoritePokemon removeObjectAtIndex:index];
}

- (NSArray<NSNumber *> *)fetchFavorites
{
    return _internalFavoritePokemon;
}

- (void)fetchPokemonData:(void (^)(NSArray<NSNumber *> *))completion
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"PokemonSwordShield" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSArray *dataArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error: nil];

    _internalDictionary = [NSMutableDictionary new];
    _internalPokemonIndexList = [NSMutableArray new];

    for (NSDictionary *dictionary in dataArray) {
        HSVPokemon *pokemon = [[HSVPokemon new] initWithDictionary:dictionary];
        if ([pokemon.pokemonID intValue] <= 890) {
            [_internalDictionary addEntriesFromDictionary:@{pokemon.pokemonID : pokemon}];
        }
    }

    _internalPokemonIndexList = [self sortedIndexDictionary:_internalDictionary];
    return completion(_internalPokemonIndexList);
}

- (NSArray<NSNumber *> *)sortedIndexDictionary:(NSDictionary *)dictionary
{
    NSArray<NSNumber *> *keys = [dictionary allKeys];
    NSArray *sortedKeys = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2];
    }];

    return sortedKeys;
}

- (NSArray<NSNumber *> *)filterWithString:(NSString *)string
{
    NSPredicate *filterPredicate = [NSPredicate predicateWithFormat:@"(name CONTAINS [cd] %@)", [string lowercaseString]];
    NSArray<HSVPokemon *> *pokemonListArray = [_internalDictionary allValues];
    NSArray<HSVPokemon *> *filteredPokemon = [pokemonListArray filteredArrayUsingPredicate: filterPredicate];

    NSMutableDictionary<NSNumber *, HSVPokemon *> *pokemonDictionary = [NSMutableDictionary new];

    for (HSVPokemon *pokemon in filteredPokemon)
            [pokemonDictionary addEntriesFromDictionary:@{pokemon.pokemonID : pokemon}];

    return [self sortedIndexDictionary:pokemonDictionary];
}



@end
