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

@property (nonatomic, copy, readonly) NSMutableDictionary<NSNumber*, HSVPokemon*> *internalNationalDexDictionary;
@property (nonatomic, copy, readonly) NSMutableDictionary<NSNumber*, HSVPokemon*> *internalGalarDexDictionary;
@property (nonatomic, copy, readonly) NSArray<NSNumber *> *internalNationalIndexList;
@property (nonatomic, copy, readonly) NSArray<NSNumber *> *internalGalarDexIndexList;
@property (nonatomic, copy) NSMutableArray<NSNumber *> *internalFavoritePokemon;

@end

@implementation HSVPokemonController

+ (instancetype)sharedPokemonController
{
    static HSVPokemonController *pokemonController = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        pokemonController = [[HSVPokemonController alloc] init];
    });

    return pokemonController;
}

- (instancetype)init
{
    if (self = [super init]) {
        _internalNationalDexDictionary = [NSMutableDictionary new];
        _internalGalarDexDictionary = [NSMutableDictionary new];
        _internalNationalIndexList = [NSArray new];
        _internalFavoritePokemon = [NSMutableArray new];
    }
    return self;
}

// MARK: - Galar Dex
- (NSDictionary<NSNumber*, HSVPokemon*> *)galarDexDictionary
{
    return _internalGalarDexDictionary;
}

- (NSArray<NSNumber *> *)fetchGalarDexIndexList
{
    return _internalGalarDexIndexList;
}

- (NSUInteger)galarDexListCount
{
    return [_internalGalarDexDictionary count];
}

- (HSVPokemon *)fetchGalarDexpokemonWithIndex:(NSNumber *)index
{
    return [_internalGalarDexDictionary objectForKey:index];
}



// MARK: - National Dex
- (NSDictionary<NSNumber*, HSVPokemon*> *)nationalDexDictionary
{
    return _internalNationalDexDictionary;
}

- (NSUInteger)nationalDexListCount
{
    return [_internalNationalIndexList count];
}

- (HSVPokemon *)fetchNationalDexpokemonWithIndex:(NSNumber *)index
{
    return [_internalNationalDexDictionary objectForKey:index];
}

- (NSArray<NSNumber *> *)pokemonIndexList
{
    return _internalNationalIndexList;
}

// MARK: - Favorites
- (void)addFavorite:(NSNumber *)number
{
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

- (NSNumber *)isfavortie:(NSNumber*)indexNumber
{
    return [_internalFavoritePokemon containsObject:indexNumber] ? @YES : @NO;
}

// MARK: - fetchPokemonData
- (void)fetchPokemonData:(void (^)(NSArray<NSNumber *> *))completion
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"PokemonSwordShield" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSArray *dataArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error: nil];

    for (NSDictionary *dictionary in dataArray) {
        HSVPokemon *pokemon = [[HSVPokemon new] initWithDictionary:dictionary];

        if ([pokemon.pokemonID intValue] <= 890) {
            [_internalNationalDexDictionary addEntriesFromDictionary:@{pokemon.pokemonID : pokemon}];

            if (pokemon.galar_dex > 0)
                [_internalGalarDexDictionary addEntriesFromDictionary:@{pokemon.galar_dex : pokemon}];
        }
    }

    _internalNationalIndexList = [self sortedIndexDictionary:_internalNationalDexDictionary];
    _internalGalarDexIndexList = [self sortedIndexDictionary:_internalGalarDexDictionary];

    return completion(_internalNationalIndexList);
}

//MARK: - sortedIndexDictionary
- (NSArray<NSNumber *> *)sortedIndexDictionary:(NSDictionary *)dictionary
{
    NSArray<NSNumber *> *keys = [dictionary allKeys];
    NSArray *sortedKeys = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2];
    }];

    return sortedKeys;
}

// MARK: filterWithString
- (NSArray<NSNumber *> *)filterWithString:(NSString *)string dictionary:(NSDictionary<NSNumber *, HSVPokemon *>*)dictionary
{
    NSPredicate *filterPredicate = [NSPredicate predicateWithFormat:@"(name CONTAINS [cd] %@)", [string lowercaseString]];
    NSArray<HSVPokemon *> *pokemonListArray = [dictionary allValues];
    NSArray<HSVPokemon *> *filteredPokemon = [pokemonListArray filteredArrayUsingPredicate: filterPredicate];

    NSMutableDictionary<NSNumber *, HSVPokemon *> *pokemonDictionary = [NSMutableDictionary new];

    for (HSVPokemon *pokemon in filteredPokemon)
            [pokemonDictionary addEntriesFromDictionary:@{pokemon.pokemonID : pokemon}];

    return [self sortedIndexDictionary:pokemonDictionary];
}

@end
