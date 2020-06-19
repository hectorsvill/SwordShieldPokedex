//
//  HSVSubmitLeagueCardNumberViewControllerDelegate.h
//  Pokedex
//
//  Created by Hector S. Villasano on 6/18/20.
//  Copyright © 2020 s. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HSVLeageCard;

NS_ASSUME_NONNULL_BEGIN

@protocol HSVSubmitLeagueCardNumberViewControllerDelegate <NSObject>

- (void)addToInternalLeageCardsWithCard;

@end

NS_ASSUME_NONNULL_END
