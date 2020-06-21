//
//  HSVLeageCard.m
//  Pokedex
//
//  Created by Hector S. Villasano on 6/16/20.
//  Copyright © 2020 s. All rights reserved.
//

#import "HSVLeagueCard.h"

@implementation HSVLeagueCard

- (instancetype)initWithCardID:(NSString *)cardID isOld:(BOOL)isOld recordName:(NSString *)recordName {
    if (self = [super init]) {
        _cardID = [cardID copy];
        _isOld = isOld;
        _recordName = [recordName copy];
        _badLeagueCardValue = @0;
    }

    return self;
}

@end
