//
//  HSVPokemon.m
//  Pokedex
//
//  Created by s on 4/22/20.
//  Copyright © 2020 s. All rights reserved.
//

#import "HSVPokemon.h"

@implementation HSVPokemon


- (instancetype)initWithName:(NSString *)name detailURL:(NSURL *)detailURL
{
    if (self = [super init]) {
        _name = [name copy];
        _detailURL = [detailURL copy];
    }

    return self;
}


@end
