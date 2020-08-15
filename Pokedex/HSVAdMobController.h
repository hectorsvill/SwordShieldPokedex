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

@property (nonatomic, readonly, copy) NSString *testUnitID;

- (instancetype) initWithTestUnitID:(NSString *)unitID;

@end

NS_ASSUME_NONNULL_END
