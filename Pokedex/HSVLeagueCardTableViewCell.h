//
//  HSVLeagueCardTableViewCell.h
//  Pokedex
//
//  Created by Hector S. Villasano on 6/10/20.
//  Copyright © 2020 s. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HSVLeagueCardTableViewCell : UITableViewCell

@property (nonatomic, copy) NSString *card;


@property (weak, nonatomic) IBOutlet UILabel *cardCodeLabel;


@end

NS_ASSUME_NONNULL_END
