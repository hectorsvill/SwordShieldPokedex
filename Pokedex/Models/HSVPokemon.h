//
//  HSVPokemon.h
//  Pokedex
//
//  Created by s on 4/22/20.
//  Copyright © 2020 s. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HSVPokemon : NSObject

@property (nonatomic, readonly, nonnull) NSString *name;
@property (nonatomic, readonly, nonnull) NSURL *detailURL;

- (instancetype)initWithName:(NSString *)name detailURL:(NSURL *)detailURL;

@end

NS_ASSUME_NONNULL_END
