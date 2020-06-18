//
//  HSVLeagueCardTableViewCell.h
//  Pokedex
//
//  Created by Hector S. Villasano on 6/10/20.
//  Copyright © 2020 s. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HSVLeagueCardTableViewCellDelegate.h"
@class HSVLeageCard;

NS_ASSUME_NONNULL_BEGIN

@interface HSVLeagueCardTableViewCell : UITableViewCell

@property (nonatomic) HSVLeageCard *leageCard;
@property (weak, nonatomic) IBOutlet UILabel *cardCodeLabel;
@property (weak, nonatomic) IBOutlet UIButton *checkedButton;

- (void) configureViews;

@property (weak) id<HSVLeagueCardTableViewCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
