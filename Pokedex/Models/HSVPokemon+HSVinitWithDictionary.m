//
//  HSVPokemon+HSVinitWithDictionary.m
//  Pokedex
//
//  Created by Hector S. Villasano on 4/23/20.
//  Copyright © 2020 s. All rights reserved.
//

#import "HSVPokemon+HSVinitWithDictionary.h"

@implementation HSVPokemon (HSVinitWithDictionary)

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSNumber *pokemonID                                     = [dictionary objectForKey:@"id"];
    NSString *name                                          = [dictionary objectForKey:@"name"];
    NSString *stage                                         = [dictionary objectForKey:@"stage"];
    NSString *galar_dex                                     = [dictionary objectForKey:@"galar_dex"];
    NSArray<NSNumber *> *base_stats                         = [dictionary objectForKey:@"base_stats"];
    NSArray<NSNumber *> *ev_yield                           = [dictionary objectForKey:@"ev_yield"];
    NSArray<NSString *> *abilities                          = [dictionary objectForKey:@"abilities"];
    NSArray<NSString *> *types                              = [dictionary objectForKey:@"types"];
    NSString *exp_grous                                     = [dictionary objectForKey:@"exp_group"];
    NSArray<NSString *> *egg_groups                         = [dictionary objectForKey:@"egg_groups"];
    NSNumber *hatch_cycles                                  = [dictionary objectForKey:@"weight"];
    NSNumber *height                                        = [dictionary objectForKey:@"height"];
    NSNumber *weight                                        = [dictionary objectForKey:@"weight"];
    NSNumber *color                                         = [dictionary objectForKey:@"color"];
    NSArray<NSDictionary *> *level_up_moves    = [dictionary objectForKey:@"level_up_moves"];

    NSString *description           = [dictionary objectForKey:@"description"];





    return [self initWithName:name pokemonID:pokemonID descriptions: description];
}

@end
