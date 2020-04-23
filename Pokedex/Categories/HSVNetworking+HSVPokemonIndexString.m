//
//  HSVNetworking+HSVPokemonIndexString.m
//  Pokedex
//
//  Created by s on 4/22/20.
//  Copyright © 2020 s. All rights reserved.
//

#import "HSVNetworking+HSVPokemonIndexString.h"

@implementation HSVNetworking (HSVPokemonIndexString)

- (NSString *)HSVCreatePokemonIndexString:(int)index
{
    int indexLength = 0;
    int indexCopy = index;

    while (indexCopy > 0) {
        indexLength += 1;
        indexCopy /= 10;
    }

    NSMutableString *zerosString = [NSMutableString string];

    while (indexLength < 3) {
        [zerosString appendString:@"0"];
        indexLength += 1;
    }

    NSString *pokemonIndexString = [NSString stringWithFormat:@"%@%d", zerosString, index];

    return  pokemonIndexString;
}

@end
