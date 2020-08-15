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

@property (nonatomic, readonly, copy) NSString *testUnitID;
@property (nonatomic, readonly, copy) NSString *pokemonDetailViewUnitID;
@property (nonatomic, readonly, copy) NSString *serebiiUnitID;

@end

@implementation HSVAdMobController

+ (instancetype)shared {
    static HSVAdMobController *adMobController = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        adMobController = [[HSVAdMobController alloc] init];
    });
    
    return adMobController;
    
}

- (instancetype)init {
    if (self = [super init]) {
        _testUnitID = @"ca-app-pub-3940256099942544/4411468910";
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
    return true;
    #endif
    return false;
}

- (GADInterstitial *) configurePokemonDetailViewInterstitial {
    return  [self checkISDebug] ? [self configureInterstitialWith:_testUnitID] : [self configureInterstitialWith: _pokemonDetailViewUnitID];
}

- (GADInterstitial *) configureSerebiiViewInterstitial {
    return [self checkISDebug] ? [self configureInterstitialWith:_testUnitID] : [self configureInterstitialWith: _serebiiUnitID];
}

@end
