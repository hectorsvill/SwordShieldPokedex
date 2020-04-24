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

- (void)fetchPokemonData:(void (^)(NSArray<NSNumber *> *))completion
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"PokemonSwordShield" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSArray *dataArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error: nil];

    _internalDictionary = [NSMutableDictionary new];

    for (NSDictionary *dictionary in dataArray) {
        HSVPokemon *pokemon = [[HSVPokemon new] initWithDictionary:dictionary];
        if ([pokemon.pokemonID intValue] <= 890) {
            [_internalDictionary addEntriesFromDictionary:@{pokemon.pokemonID : pokemon}];
        }
    }

    return completion([self sortedIndexDictionary:_internalDictionary]);
}

- (NSArray<NSNumber *> *)sortedIndexDictionary:(NSDictionary *)dictionary
{
    NSArray<NSNumber *> *keys = [dictionary allKeys];
    NSArray *sortedKeys = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2];
    }];

    return sortedKeys;
}

- (NSArray<HSVPokemon *> *)filterWithString:(NSString *)string
{

    NSPredicate *filterPredicate = [NSPredicate predicateWithFormat:@"(name CONTAINS %@)", [string lowercaseString]];

    NSArray<HSVPokemon *> *pokemonListArray = [_internalDictionary allValues];

    NSArray<HSVPokemon *> *filtered = [pokemonListArray filteredArrayUsingPredicate: filterPredicate];

    return filtered;
}

@end
