//
//  HSVLeagueCardsTableViewController.m
//  Pokedex
//
//  Created by Hector S. Villasano on 6/10/20.
//  Copyright © 2020 s. All rights reserved.
//

#import "HSVLeagueCardsTableViewController.h"
#import "HSVLeagueCardTableViewCell.h"
#import <CloudKit/CloudKit.h>


@interface HSVLeagueCardsTableViewController ()

@property (nonatomic, copy) NSArray<NSString *> *internalCards;

@end

@implementation HSVLeagueCardsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    CKRecordID *recordId = 
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_internalCards count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HSVLeagueCardTableViewCell *cell = (HSVLeagueCardTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"LeagueCardCell" forIndexPath:indexPath];

    NSString *card = [_internalCards objectAtIndex:indexPath.row];

    cell.card = card;
    return  cell;
}

@end
