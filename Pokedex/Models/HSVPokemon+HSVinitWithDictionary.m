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
    NSString *name = dictionary[@"name"];
    NSString *description = dictionary[@"description"];
    NSNumber *pokemonID = [dictionary objectForKey:@"id"];

    return [self initWithName:name pokemonID:pokemonID descriptions: description];
}

@end
