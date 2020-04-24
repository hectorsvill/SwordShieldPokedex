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

@property (nonatomic, readonly, nonnull) NSString *name;
@property (nonatomic, readonly, nonnull) NSNumber *pokemonID;
@property (nonatomic, readonly, nonnull) NSString *pokemondescription;
@property (nonatomic, readonly, nonnull) NSNumber *weight;
@property (nonatomic, readonly, nonnull) NSString *color;
@property (nonatomic, readonly, nonnull) NSString *tms;
@property (nonatomic, readonly, nonnull) NSString *ev_yield;
@property (nonatomic, readonly, nonnull) NSString *trs;
@property (nonatomic, readonly, nonnull) NSString *items;
@property (nonatomic, readonly, nonnull) NSString *abilities;
@property (nonatomic, readonly, nonnull) NSArray *level_up_moves;
@property (nonatomic, readonly, nonnull) NSArray *base_stats;

- (instancetype)initWithName:(NSString *)name
                   pokemonID:(NSNumber *)pokemonID
                 descriptions:(NSString *)pokemondescription;

@end

NS_ASSUME_NONNULL_END
