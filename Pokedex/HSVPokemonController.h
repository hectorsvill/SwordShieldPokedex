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

- (NSUInteger)internalDictionaryCount;
- (void)fetchPokemonData:(void (^)(NSArray<NSNumber *> *))completion;
- (HSVPokemon *)fetchpokemonWithIndex:(NSNumber *)index;

- (void)addFavorite:(NSNumber *)number;
- (void)removeInternalFavoritePokemonAtIndexe:(int)index;
- (NSArray<NSNumber *> *)fetchFavorites;
- (NSNumber *)isfavortie:(NSNumber*)indexNumber;

- (NSArray  <NSNumber *> *)sortedIndexDictionary:(NSDictionary *)dictionary;
- (NSArray  <NSNumber *> *)filterWithString:(NSString *)string;
- (NSArray  <NSNumber *> *)pokemonIndexList;

@end

NS_ASSUME_NONNULL_END
