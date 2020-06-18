//
//  HSVLeagueCardTableViewCellDelegate.h
//  Pokedex
//
//  Created by Hector S. Villasano on 6/17/20.
//  Copyright © 2020 s. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol HSVLeagueCardTableViewCellDelegate <NSObject>

- (void)checkedButtonPressed:(BOOL)isOld cardID:(NSString *)cardID;

@end

NS_ASSUME_NONNULL_END
