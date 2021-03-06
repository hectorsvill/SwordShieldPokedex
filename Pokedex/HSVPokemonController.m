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
@property (nonatomic) NSMutableArray<NSNumber *> *internalFavoritePokemon;
@property (nonatomic) NSMutableArray<NSString *> *internalOldLeageCardList;

@end

@implementation HSVPokemonController

+ (instancetype)sharedPokemonController {
    static HSVPokemonController *pokemonController = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        pokemonController = [[HSVPokemonController alloc] init];
    });

    return pokemonController;
}

- (instancetype)init {
    if (self = [super init]) {
        _internalNationalDexDictionary = [NSMutableDictionary new];
        _internalGalarDexDictionary = [NSMutableDictionary new];
        _internalNationalIndexList = [NSArray new];
        _internalFavoritePokemon =  [NSMutableArray array];
        _internalOldLeageCardList = [NSMutableArray array];
    }

    NSArray *saveFavoritePokemon = [[NSUserDefaults standardUserDefaults] objectForKey:@"InternalFavoritePokemon"];
    if ([saveFavoritePokemon isKindOfClass:[NSArray class]] && saveFavoritePokemon != nil) {
        _internalFavoritePokemon = [NSMutableArray arrayWithArray:saveFavoritePokemon];
    }

    NSArray *savedOldLeageCards = [[NSUserDefaults standardUserDefaults] objectForKey:@"InternalOldLeageCardList"];
    if ([savedOldLeageCards isKindOfClass:[NSArray class]] && savedOldLeageCards) {
        _internalOldLeageCardList = [NSMutableArray arrayWithArray:savedOldLeageCards];
    }

    return self;
}

// MARK: - Galar Dex
- (NSDictionary<NSNumber*, HSVPokemon*> *)galarDexDictionary {
    return _internalGalarDexDictionary;
}

- (NSArray<NSNumber *> *)fetchGalarDexIndexList {
    return _internalGalarDexIndexList;
}

- (NSUInteger)galarDexListCount {
    return [_internalGalarDexDictionary count];
}

- (HSVPokemon *)fetchGalarDexpokemonWithIndex:(NSNumber *)index {
    return [_internalGalarDexDictionary objectForKey:index];
}

// MARK: - National Dex
- (NSDictionary<NSNumber*, HSVPokemon*> *)nationalDexDictionary {
    return _internalNationalDexDictionary;
}

- (NSUInteger)nationalDexListCount {
    return [_internalNationalIndexList count];
}

- (NSArray<NSString *>*) fetchNationalPokemonNames {
    NSMutableArray<NSString *> *nameList = [NSMutableArray new];
    for (NSNumber *number in _internalNationalIndexList) {
        HSVPokemon *pokemon = [_internalNationalDexDictionary objectForKey:number];
        [nameList addObject:pokemon.name];
    }
    
    return nameList;
}

- (NSArray<NSString *>*) fetchGalarPokemonNames {
    NSMutableArray<NSString *> *nameList = [NSMutableArray new];
    for (NSNumber *number in _internalGalarDexIndexList) {
        HSVPokemon *pokemon = [_internalGalarDexDictionary objectForKey:number];
        [nameList addObject:pokemon.name];
    }
    
    return nameList;
}

- (HSVPokemon *)fetchNationalDexpokemonWithIndex:(NSNumber *)index {
    return [_internalNationalDexDictionary objectForKey:index];
}

- (NSArray<NSNumber *> *)pokemonIndexList {
    return _internalNationalIndexList;
}

// MARK: - Favorites
- (void)addFavorite:(NSNumber *)number {
    if ( ![_internalFavoritePokemon containsObject:number]) {
        [_internalFavoritePokemon addObject:number];
        [self saveToUserDefaults];
    }
}

- (void)removeInternalFavoritePokemon:(NSNumber *)number {
    [_internalFavoritePokemon removeObject:number];
    [self saveToUserDefaults];
}

- (NSArray<NSNumber *> *)fetchFavorites {
    return _internalFavoritePokemon;
}

- (NSNumber *)isfavortie:(NSNumber*)indexNumber {
    return [_internalFavoritePokemon containsObject:indexNumber] ? @YES : @NO;
}

// MARK: - User Defaults

- (void)saveToUserDefaults {
    [[NSUserDefaults standardUserDefaults] setObject:_internalFavoritePokemon forKey:@"InternalFavoritePokemon"];
}

- (void)saveSearchViewRegion:(Pokedex)type {
    if (type == National || type == Galar) {
        [[NSUserDefaults standardUserDefaults] setInteger:type forKey:@"SearchViewRegionSetting"];
    }
}

- (Pokedex)fetchSearchViewRegion {
    NSInteger type = [[NSUserDefaults standardUserDefaults] integerForKey:@"SearchViewRegionSetting"];
    return type;
}

// MARK: - fetchPokemonData
- (void)fetchPokemonDataFromJson:(void (^)(NSArray<NSNumber *> *))completion {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"PokemonSwordShield" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSArray *dataArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error: nil];

    for (NSDictionary *dictionary in dataArray) {
        HSVPokemon *pokemon = [[HSVPokemon new] initWithDictionary:dictionary];

        if ([pokemon.national_dex intValue] <= 890) {
            [_internalNationalDexDictionary addEntriesFromDictionary:@{pokemon.national_dex : pokemon}];

            if (pokemon.galar_dex.intValue > 0)
                [_internalGalarDexDictionary addEntriesFromDictionary:@{pokemon.galar_dex : pokemon}];
        }
    }

    _internalNationalIndexList = [self sortedIndexDictionary:_internalNationalDexDictionary];
    _internalGalarDexIndexList = [self sortedIndexDictionary:_internalGalarDexDictionary];

    return completion(_internalNationalIndexList);
}

//MARK: - sortedIndexDictionary
- (NSArray<NSNumber *> *)sortedIndexDictionary:(NSDictionary *)dictionary {
    NSArray<NSNumber *> *keys = [dictionary allKeys];
    NSArray *sortedKeys = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2];
    }];

    return sortedKeys;
}

// MARK: filterWithString
- (NSArray<NSNumber *> *)filterWithString:(NSString *)string dictionary:(NSDictionary<NSNumber *, HSVPokemon *>*)dictionary pokedex_type:(Pokedex)pokedex_type {
    NSPredicate *filterPredicate = [NSPredicate predicateWithFormat:@"(name CONTAINS [cd] %@)", [string lowercaseString]];
    NSArray<HSVPokemon *> *pokemonListArray = [dictionary allValues];
    NSArray<HSVPokemon *> *filteredPokemon = [pokemonListArray filteredArrayUsingPredicate: filterPredicate];

    NSMutableDictionary<NSNumber *, HSVPokemon *> *pokemonDictionary = [NSMutableDictionary new];

    for (HSVPokemon *pokemon in filteredPokemon)
        [pokemonDictionary addEntriesFromDictionary:@{pokedex_type == National ? pokemon.national_dex : pokemon.galar_dex : pokemon}]; //

    return [self sortedIndexDictionary:pokemonDictionary];
}

// Mark - League Card Controller

- (NSArray<NSString *> *)oldLeagueCardList {
    return [_internalOldLeageCardList copy];
}

- (void)addOldLeageCard:(NSString *)cardID {
    if (![_internalOldLeageCardList containsObject:cardID]) {
        [_internalOldLeageCardList addObject:cardID];
        [self saveOldLeageCardsToUserDefaults];
    }
}

- (void)deleteOldLeageCard:(NSString *)cardID {
    [_internalOldLeageCardList removeObject:cardID];
    [self saveOldLeageCardsToUserDefaults];
}

- (void) saveOldLeageCardsToUserDefaults {
    [[NSUserDefaults standardUserDefaults] setObject:_internalOldLeageCardList forKey:@"InternalOldLeageCardList"];
}

@end
