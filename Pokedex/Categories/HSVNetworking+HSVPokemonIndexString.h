//
//  HSVNetworking+HSVPokemonIndexString.h
//  Pokedex
//
//  Created by s on 4/22/20.
//  Copyright © 2020 s. All rights reserved.
//

#import "HSVNetworking.h"

NS_ASSUME_NONNULL_BEGIN

@interface HSVNetworking (HSVPokemonIndexString)

- (NSString *)HSVCreatePokemonIndexString:(int)index;

@end

NS_ASSUME_NONNULL_END
