//
//  HSVAdMobController.h
//  Pokedex
//
//  Created by Hector Villasano on 8/15/20.
//  Copyright © 2020 s. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HSVAdMobController : NSObject

+ (instancetype)shared;
- (GADInterstitial *) configurePokemonDetailViewInterstitial;
- (GADInterstitial *) configureSerebiiViewInterstitial;

@end

NS_ASSUME_NONNULL_END
