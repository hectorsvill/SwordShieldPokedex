//
//  HSVPokemon+HSVinitWithDictionary.h
//  Pokedex
//
//  Created by Hector S. Villasano on 4/23/20.
//  Copyright © 2020 s. All rights reserved.
//

#import "HSVPokemon.h"

NS_ASSUME_NONNULL_BEGIN

@interface HSVPokemon (HSVinitWithDictionary)

- (instancetype)initWithDictionary:(NSDictionary*)dictionary;

@end

NS_ASSUME_NONNULL_END
