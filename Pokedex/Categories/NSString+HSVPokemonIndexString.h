//
//  NSString+HSVPokemonIndexString.h
//  Pokedex
//
//  Created by Hector S. Villasano on 4/23/20.
//  Copyright © 2020 s. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (HSVPokemonIndexString)

- (NSString *)HSVCreatePokemonIndexString:(int)index;

@end

NS_ASSUME_NONNULL_END
