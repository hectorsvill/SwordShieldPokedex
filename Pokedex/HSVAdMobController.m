//
//  HSVAdMobController.m
//  Pokedex
//
//  Created by Hector Villasano on 8/15/20.
//  Copyright © 2020 s. All rights reserved.
//

@import GoogleMobileAds;
#import "HSVAdMobController.h"

@interface HSVAdMobController ()

@property (nonatomic, readonly, copy) NSString *pokemonDetailViewUnitID;
@property (nonatomic, readonly, copy) NSString *serebiiUnitID;

@end

@implementation HSVAdMobController

- (instancetype)initWithTestUnitID:(NSString *)unitID {
    if (self = [super init]) {
        _testUnitID = @"ca-app-pub-3940256099942544/441146891";
        _pokemonDetailViewUnitID = @"";
        _serebiiUnitID = @"";
    }
    
    return  self;
}

- (GADInterstitial *) configureInterstitialWith:(NSString *)unitID {
    GADInterstitial *ad = [[GADInterstitial alloc] initWithAdUnitID:unitID];
    GADRequest *request = [GADRequest request];
    [ad loadRequest:request];
    return ad;
}

- (BOOL) checkISDebug {
    #if DEBUG
    NSArray *arguments = [[NSProcessInfo processInfo] arguments];
    if ([arguments containsObject:@"enable-testing"]) {
        return true;
    }
    #endif
    return false;
}


- (GADInterstitial *) configurePokemonDetailViewInterstitial {
    if (![self checkISDebug]) {
        return [self configureInterstitialWith: _pokemonDetailViewUnitID];
    } else {
        return [self configureInterstitialWith:_testUnitID];
    }
}

- (GADInterstitial *) configureSerebiiViewInterstitial {
    if (![self checkISDebug]) {
        return [self configureInterstitialWith: _serebiiUnitID];
    } else {
        return [self configureInterstitialWith:_testUnitID];
    }
}

@end
