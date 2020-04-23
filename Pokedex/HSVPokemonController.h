//
//  HSVPokemonController.h
//  Pokedex
//
//  Created by Hector S. Villasano on 4/23/20.
//  Copyright © 2020 s. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HSVPokemon;

NS_ASSUME_NONNULL_BEGIN

@interface HSVPokemonController : NSObject

@property (nonatomic, copy, readonly) NSArray<HSVPokemon *> *pokemonList;

- (NSUInteger)pokemonListCount;
- (HSVPokemon *)pokemonWithIndex:(NSInteger)index;
- (void)fetchPokemonData:(void (^)(void))completion;

@end

NS_ASSUME_NONNULL_END
