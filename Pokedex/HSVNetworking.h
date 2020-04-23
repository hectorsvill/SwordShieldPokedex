//
//  HSVNetworking.h
//  Pokedex
//
//  Created by s on 4/22/20.
//  Copyright © 2020 s. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HSVPokemon;

NS_ASSUME_NONNULL_BEGIN

@interface HSVNetworking : NSObject

- (void)fetchPokemonList:(void(^)(NSArray<HSVPokemon *> *, NSError *))completion;
- (void)fetchImageDataWithIndex:(int)index completion:(void(^)(NSData *))completion;

@end

NS_ASSUME_NONNULL_END
