//
//  HSVLeageCard.h
//  Pokedex
//
//  Created by Hector S. Villasano on 6/16/20.
//  Copyright © 2020 s. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HSVLeageCard : NSObject

@property (nonatomic, strong) NSString *cardID;
@property (nonatomic) BOOL isOld;
@property (nonatomic) NSString *recordName;

- (instancetype)initWithCardID:(NSString *)cardID isOld:(BOOL)isOld recordName:(NSString *)recordName;

@end

NS_ASSUME_NONNULL_END
