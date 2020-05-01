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
@property (nonatomic, copy, readonly) NSArray<NSNumber *> *internalPokemonIndexList;
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
        _internalPokemonIndexList = [NSArray new];
        _internalFavoritePokemon = [NSMutableArray new];
    }
    return self;
}

- (NSUInteger)nationalDexDictionaryCount
{
    return [_internalNationalDexDictionary count];
}

- (HSVPokemon *)fetchNationalDexpokemonWithIndex:(NSNumber *)index
{
    return [_internalNationalDexDictionary objectForKey:index];
}

- (NSArray<NSNumber *> *)pokemonIndexList
{
    return _internalPokemonIndexList;
}

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

- (void)fetchPokemonData:(void (^)(NSArray<NSNumber *> *))completion
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"PokemonSwordShield" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSArray *dataArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error: nil];

    for (NSDictionary *dictionary in dataArray) {
        HSVPokemon *pokemon = [[HSVPokemon new] initWithDictionary:dictionary];

        if ([pokemon.pokemonID intValue] <= 890) {
            [_internalNationalDexDictionary addEntriesFromDictionary:@{pokemon.pokemonID : pokemon}];
        }



    }

    _internalPokemonIndexList = [self sortedIndexDictionary:_internalNationalDexDictionary];
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
    NSArray<HSVPokemon *> *pokemonListArray = [_internalNationalDexDictionary allValues];
    NSArray<HSVPokemon *> *filteredPokemon = [pokemonListArray filteredArrayUsingPredicate: filterPredicate];

    NSMutableDictionary<NSNumber *, HSVPokemon *> *pokemonDictionary = [NSMutableDictionary new];

    for (HSVPokemon *pokemon in filteredPokemon)
            [pokemonDictionary addEntriesFromDictionary:@{pokemon.pokemonID : pokemon}];

    return [self sortedIndexDictionary:pokemonDictionary];
}

@end
