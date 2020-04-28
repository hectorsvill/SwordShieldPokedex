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

//@property (nonatomic, copy, readonly) NSMutableDictionary<NSNumber*, HSVPokemon*> *pokemonDictionary;
//@property (nonatomic, copy) NSArray<NSNumber *> *pokemonIndexList;
//@property (nonatomic, copy) NSArray<NSNumber *> *favoritePokemon;

- (NSUInteger)pokemonListCount;
- (void)fetchPokemonData:(void (^)(NSArray<NSNumber *> *))completion;
- (HSVPokemon *)fetchpokemonWithIndex:(NSNumber *)index;

- (NSArray  <NSNumber *> *)sortedIndexDictionary:(NSDictionary *)dictionary;
- (NSArray  <NSNumber *> *)filterWithString:(NSString *)string;
- (NSArray  <NSNumber *> *)pokemonIndexList;

- (void)addFavorite:(NSNumber *)number;
- (void)removeInternalFavoritePokemonAtIndexe:(int)index;
- (NSArray<NSNumber *> *)fetchFavorites;
- (NSNumber *)isfavortie:(NSNumber*)indexNumber;


@end

NS_ASSUME_NONNULL_END
