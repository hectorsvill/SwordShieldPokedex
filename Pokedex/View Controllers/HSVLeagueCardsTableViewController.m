//
//  HSVLeagueCardsTableViewController.m
//  Pokedex
//
//  Created by Hector S. Villasano on 6/10/20.
//  Copyright © 2020 s. All rights reserved.
//

#import "HSVLeagueCardsTableViewController.h"
#import "HSVLeagueCardTableViewCell.h"
#import "NationalGalarPokedex-Swift.h"
#import "HSVLeageCard.h"
#import "HSVSubmitLeagueCardNumberViewController.h"

#import <CloudKit/CloudKit.h>


@interface HSVLeagueCardsTableViewController ()

@property (nonatomic) UIRefreshControl *refreshControl;
@property (nonatomic) HSVCloudFramework *cloudFramework;
@property (nonatomic, copy) NSArray<HSVLeageCard *> *internalCards;

@end

@implementation HSVLeagueCardsTableViewController
@synthesize refreshControl;

- (void)viewDidLoad {
    [super viewDidLoad];

    [self createRefreshControl];
    self.internalCards = [NSMutableArray array];
    self.cloudFramework = [HSVCloudFramework new];

    [self.refreshControl beginRefreshing];
    [self fetchLeageCards];
}

- (void)createRefreshControl {
    self.refreshControl = [UIRefreshControl new];
    [self.refreshControl addTarget:self action:@selector(fetchLeageCards) forControlEvents:UIControlEventValueChanged];
    [self.refreshControl setTintColor:UIColor.systemRedColor];
    self.tableView.refreshControl = self.refreshControl;
}

-(void)refresh {
    [self fetchLeageCards];
}

- (void) fetchLeageCards {
    [self.cloudFramework fetchRecordsWithRecordType:@"LeageCardID" completion:^(NSArray<CKRecord *> *records, NSError *error) {
        if (error != nil) {
            NSLog(@"%@", error.localizedDescription);
            return;
        }

        NSMutableArray *cards = [NSMutableArray array];
        for (CKRecord *record in records) {
            NSString *cardID = (NSString *)[record objectForKey:@"cardID"];
            HSVLeageCard *leageCard = [[HSVLeageCard new] initWithCardID:cardID isOld:false];
            [cards addObject:leageCard];
        }

        self.internalCards = cards;

        dispatch_async(dispatch_get_main_queue(), ^{
            [self.refreshControl endRefreshing];
            [self.tableView reloadData];
        });
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"viewLeageCardSegue"]) {
        HSVLeagueCardTableViewCell *cell = (HSVLeagueCardTableViewCell *)sender;
        NSString *cardID = cell.cardCodeLabel.text;

        HSVSubmitLeagueCardNumberViewController *vc = (HSVSubmitLeagueCardNumberViewController *)segue.destinationViewController;
        vc.cardID = cardID;
    }
}

// MARK: Table Vide Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 72;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_internalCards count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HSVLeagueCardTableViewCell *cell = (HSVLeagueCardTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"LeagueCardCell" forIndexPath:indexPath];

    HSVLeageCard *card = [_internalCards objectAtIndex:indexPath.row];

    cell.card = card.cardID;

    cell.cardCodeLabel.text = card.cardID;
    return  cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return section == 0 ? @"NEW" : @"OLD";
}

@end
