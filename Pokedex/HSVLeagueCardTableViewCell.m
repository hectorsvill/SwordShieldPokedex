//
//  HSVLeagueCardTableViewCell.m
//  Pokedex
//
//  Created by Hector S. Villasano on 6/10/20.
//  Copyright © 2020 s. All rights reserved.
//

#import "HSVLeagueCardTableViewCell.h"
#import "HSVLeagueCard.h"
@implementation HSVLeagueCardTableViewCell

- (void) configureViews {
    self.cardCodeLabel.text = self.leagueCard.cardID;
    [self configureButtonImage];
}

- (void)configureButtonImage {
    NSString *imageName = !self.leagueCard.isOld ? @"checkmark.square" : @"checkmark.square.fill";
    UIImage *image = [UIImage systemImageNamed:imageName];
    [self.checkedButton setImage:image forState:UIControlStateNormal];
}

- (IBAction)checkButtonPressed:(id)sender {
    BOOL isOld = self.leagueCard.isOld;
    self.leagueCard.isOld = !isOld;
    [self configureButtonImage];
    [_delegate checkedButtonPressed:isOld recordName:self.leagueCard.recordName];
}

@end
