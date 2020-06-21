//
//  HSVLeagueCardsTableViewController.h
//  Pokedex
//
//  Created by Hector S. Villasano on 6/10/20.
//  Copyright © 2020 s. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HSVLeagueCardTableViewCellDelegate.h"
#import "HSVSubmitLeagueCardNumberViewControllerDelegate.h"
NS_ASSUME_NONNULL_BEGIN

@class CloudFramework;

@interface HSVLeagueCardsTableViewController : UITableViewController<HSVLeagueCardTableViewCellDelegate, HSVSubmitLeagueCardNumberViewControllerDelegate>



@end

NS_ASSUME_NONNULL_END
