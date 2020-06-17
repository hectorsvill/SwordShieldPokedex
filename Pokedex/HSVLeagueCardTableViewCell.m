//
//  HSVLeagueCardTableViewCell.m
//  Pokedex
//
//  Created by Hector S. Villasano on 6/10/20.
//  Copyright © 2020 s. All rights reserved.
//

#import "HSVLeagueCardTableViewCell.h"
#import "HSVLeageCard.h"
@implementation HSVLeagueCardTableViewCell

- (void) configureViews {
    self.cardCodeLabel.text = self.leageCard.cardID;
    [self configureButtonImage];
}

- (void)configureButtonImage{
    NSString *imageName = !self.leageCard.isOld ? @"checkmark.square" : @"checkmark.square.fill";
    UIImage *image = [UIImage systemImageNamed:imageName];
    [self.checkedButton setImage:image forState:UIControlStateNormal];
}

- (IBAction)checkButtonPressed:(id)sender {
    BOOL isOld = self.leageCard.isOld;
    self.leageCard.isOld = !isOld;
    [self configureButtonImage];
}

@end
