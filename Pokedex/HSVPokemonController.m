//
//  HSVPokemonController.m
//  Pokedex
//
//  Created by Hector S. Villasano on 4/23/20.
//  Copyright © 2020 s. All rights reserved.
//

#import "HSVPokemonController.h"
#import "HSVPokemon.h"
@interface HSVPokemonController()

@property (nonatomic, copy) NSMutableArray<HSVPokemon*> *internalPokemonList;

@end

@implementation HSVPokemonController

- (instancetype)init
{
    if (self = [super init]) {
        _internalPokemonList = [[self pokemonList] mutableCopy];
    }
    return self;
}

- (NSUInteger)pokemonListCount
{
    return [_internalPokemonList count];
}

- (HSVPokemon *)pokemonWithIndex:(NSInteger)index
{
    return [_internalPokemonList objectAtIndex:index];
}

- (void)fetchPokemonData:(void (^)(NSDictionary *))completion
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"PokemonSwordShield" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error: nil];
    return completion(dictionary);
}

@end
