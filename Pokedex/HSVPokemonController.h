//
//  HSVPokemonController.h
//  Pokedex
//
//  Created by Hector S. Villasano on 4/23/20.
//  Copyright © 2020 s. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HSVPokedex_Type.h"

@protocol HSVPokemonControllerProtocol;

@class HSVPokemon;

NS_ASSUME_NONNULL_BEGIN

@interface HSVPokemonController : NSObject

+ (instancetype)sharedPokemonController;

@property (nonatomic, weak) id<HSVPokemonControllerProtocol> delegate;

- (NSDictionary<NSNumber*, HSVPokemon*> *)galarDexDictionary;
- (NSArray<NSNumber *> *)fetchGalarDexIndexList;
- (NSUInteger)galarDexListCount;
- (HSVPokemon *)fetchGalarDexpokemonWithIndex:(NSNumber *)index;


- (NSDictionary<NSNumber*, HSVPokemon*> *)nationalDexDictionary;
- (NSUInteger)nationalDexListCount;
- (HSVPokemon *)fetchNationalDexpokemonWithIndex:(NSNumber *)index;
- (NSArray  <NSNumber *> *)pokemonIndexList;

- (void)addFavorite:(NSNumber *)number;
- (void)removeInternalFavoritePokemon:(NSNumber *)object;
- (NSArray<NSNumber *> *)fetchFavorites;
- (NSNumber *)isfavortie:(NSNumber*)indexNumber;

- (void)fetchPokemonDataFromJson:(void (^)(NSArray<NSNumber *> *))completion;
- (NSArray  <NSNumber *> *)sortedIndexDictionary:(NSDictionary *)dictionary;
- (NSArray<NSNumber *> *)filterWithString:(NSString *)string dictionary:(NSDictionary<NSNumber *, HSVPokemon *>*)dictionary pokedex_type:(Pokedex)pokedex_type;

- (NSArray<NSString *> *)oldLeageCardList;
- (void)addOldLeageCard:(NSString *)cardID;
- (void)deleteOldLeageCard:(NSString *)cardID;


@end

NS_ASSUME_NONNULL_END
