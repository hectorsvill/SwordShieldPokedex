//
//  HSVPokemon.h
//  Pokedex
//
//  Created by s on 4/22/20.
//  Copyright © 2020 s. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HSVPokemon : NSObject


@property (nonatomic, readonly, copy, nonnull) NSNumber                 *national_dex;
@property (nonatomic, readonly, copy, nonnull) NSString                 *name;
@property (nonatomic, readonly, copy, nonnull) NSString                 *stage;
@property (nonatomic, readonly, copy, nonnull) NSNumber                 *galar_dex;
@property (nonatomic, readonly, copy, nonnull) NSArray<NSNumber *>      *base_stats;
@property (nonatomic, readonly, copy, nonnull) NSArray<NSNumber *>      *ev_yield;
@property (nonatomic, readonly, copy, nonnull) NSArray<NSString *>      *abilities;
@property (nonatomic, readonly, copy, nonnull) NSArray<NSString *>      *types;
@property (nonatomic, readonly, copy, nonnull) NSString                 *exp_groups;
@property (nonatomic, readonly, copy, nonnull) NSArray<NSString *>      *egg_groups;
@property (nonatomic, readonly, copy, nonnull) NSNumber                 *hatch_cycles;
@property (nonatomic, readonly, copy, nonnull) NSNumber                 *height;
@property (nonatomic, readonly, copy, nonnull) NSNumber                 *weight;
@property (nonatomic, readonly, copy, nonnull) NSNumber                 *color;
@property (nonatomic, readonly, copy, nonnull) NSArray<NSArray *>  *level_up_moves;
@property (nonatomic, readonly, copy, nonnull) NSArray<NSString *>      *egg_moves;
@property (nonatomic, readonly, copy, nonnull) NSArray<NSNumber *>      *tms;
@property (nonatomic, readonly, copy, nonnull) NSArray<NSNumber *>      *trs;
@property (nonatomic, readonly, copy, nonnull) NSArray<NSDictionary *>  *evolutions;
@property (nonatomic, readonly, copy, nonnull) NSString                 *pokedexdescription;

- (instancetype)initWithPokemonID:(NSNumber *)pokemonID
                             name:(NSString *)name
                            stage:(NSString *)stage
                        galar_dex:(NSNumber *)galar_dex
                       base_stats:(NSArray<NSNumber *> *)base_stats
                         ev_yield:(NSArray<NSNumber *> *)ev_yield
                         abilities:(NSArray<NSString *> *)abilities
                            types:(NSArray<NSString *> *)types
                       exp_groups:(NSString *)exp_groups
                       egg_groups:(NSArray<NSString *> *)egg_groups
                     hatch_cycles:(NSNumber *)hatch_cycles
                           height:(NSNumber *)height
                           weight:(NSNumber *)weight
                            color:(NSNumber *)color
                   level_up_moves:(NSArray<NSArray *> *)level_up_moves
                        egg_moves:(NSArray<NSString *> *)egg_moves
                              tms:(NSArray<NSNumber *> *)tms
                              trs:(NSArray<NSNumber *> *)trs
                        evolution:(NSArray<NSDictionary *> *)evolutions
               pokedexdescription:(NSString *)pokedexdescription;

@end

NS_ASSUME_NONNULL_END
