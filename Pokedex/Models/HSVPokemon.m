//
//  HSVPokemon.m
//  Pokedex
//
//  Created by s on 4/22/20.
//  Copyright © 2020 s. All rights reserved.
//

#import "HSVPokemon.h"

@implementation HSVPokemon

- (instancetype)initWithPokemonID:(NSNumber *)pokemonID name:(NSString *)name stage:(NSString *)stage galar_dex:(NSNumber *)galar_dex base_stats:(NSArray<NSNumber *> *)base_stats ev_yield:(NSArray<NSNumber *> *)ev_yield abilities:(NSArray<NSString *> *)abilities types:(NSArray<NSString *> *)types exp_groups:(NSString *)exp_groups egg_groups:(NSArray<NSString *> *)egg_groups hatch_cycles:(NSNumber *)hatch_cycles height:(NSNumber *)height weight:(NSNumber *)weight color:(NSNumber *)color level_up_moves:(NSArray<NSArray *> *)level_up_moves egg_moves:(NSArray<NSString *> *)egg_moves tms:(NSArray<NSNumber *> *)tms trs:(NSArray<NSNumber *> *)trs evolution:(NSArray<NSDictionary *> *)evolutions pokedexdescription:(NSString *)pokedexdescription
{

    if (self = [super init]) {
        _national_dex = [pokemonID copy];
        _name = [name copy];
        _stage = [stage copy];
        _galar_dex = [galar_dex copy];
        _base_stats = [base_stats copy];
        _ev_yield = [base_stats copy];
        _abilities = [abilities copy];
        _types = [types copy];
        _exp_groups = [exp_groups copy];
        _egg_groups = [egg_groups copy];
        _hatch_cycles = [hatch_cycles copy];
        _height = [height copy];
        _weight = [weight copy];
        _color = [color copy];
        _level_up_moves = [level_up_moves copy];
        _egg_moves = [egg_moves copy];
        _tms = [tms copy];
        _trs = [trs copy];
        _evolutions = [evolutions copy];
        _pokedexdescription = [pokedexdescription copy];
    }

    return self;
}

@end


