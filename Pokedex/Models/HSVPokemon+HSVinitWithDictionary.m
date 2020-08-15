//
//  HSVPokemon+HSVinitWithDictionary.m
//  Pokedex
//
//  Created by Hector S. Villasano on 4/23/20.
//  Copyright © 2020 s. All rights reserved.
//

#import "HSVPokemon+HSVinitWithDictionary.h"

@implementation HSVPokemon (HSVinitWithDictionary)

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    NSNumber *pokemonID                     = [dictionary objectForKey:@"id"];
    NSString *name                          = [dictionary objectForKey:@"name"];
    NSString *stage                         = [dictionary objectForKey:@"stage"];
    NSString *galar_dexString               = [dictionary objectForKey:@"galar_dex"];
    NSNumber *galar_dex                     = [NSNumber numberWithLong:[galar_dexString integerValue]] ;
    NSArray<NSNumber *> *base_stats         = [dictionary objectForKey:@"base_stats"];
    NSArray<NSNumber *> *ev_yield           = [dictionary objectForKey:@"ev_yield"];
    NSArray<NSString *> *abilities          = [dictionary objectForKey:@"abilities"];
    NSArray<NSString *> *types              = [dictionary objectForKey:@"types"];
    NSString *exp_group                     = [dictionary objectForKey:@"exp_group"];
    NSArray<NSString *> *egg_groups         = [dictionary objectForKey:@"egg_groups"];
    NSNumber *hatch_cycles                  = [dictionary objectForKey:@"weight"];
    NSNumber *height                        = [dictionary objectForKey:@"height"];
    NSNumber *weight                        = [dictionary objectForKey:@"weight"];
    NSNumber *color                         = [dictionary objectForKey:@"color"];
    NSArray<NSArray *> *level_up_moves = [dictionary objectForKey:@"level_up_moves"];
    NSArray<NSString *> *egg_moves          = [dictionary objectForKey:@"egg_moves"];
    NSArray<NSNumber *> *tms                = [dictionary objectForKey:@"tms"];
    NSArray<NSNumber *> *trs                = [dictionary objectForKey:@"trs"];
    NSArray<NSDictionary *> *evolutions     = [dictionary objectForKey:@"evolutions"];
    NSString *pokedexdescription            = [dictionary objectForKey:@"description"];

    return [self initWithPokemonID:pokemonID name:name stage:stage galar_dex:galar_dex base_stats:base_stats ev_yield:ev_yield abilities:abilities types:types exp_groups:exp_group egg_groups:egg_groups hatch_cycles:hatch_cycles height:height weight:weight color:color level_up_moves:level_up_moves egg_moves:egg_moves tms:tms trs:trs evolution:evolutions pokedexdescription:pokedexdescription];
}

@end
