//
//  HSVLeageCard.m
//  Pokedex
//
//  Created by Hector S. Villasano on 6/16/20.
//  Copyright © 2020 s. All rights reserved.
//

#import "HSVLeageCard.h"

@implementation HSVLeageCard

- (instancetype)initWithCardID:(NSString *)cardID isOld:(BOOL)isOld recordName:(NSString *)recordName {
    if (self = [super init]) {
        _cardID = [cardID copy];
        _isOld = isOld;
        _recordName = [recordName copy];
        _badLeageCardValue = @0;
    }

    return self;
}

@end
