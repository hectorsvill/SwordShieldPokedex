//
//  HSVLeagueCardsTableViewController.m
//  Pokedex
//
//  Created by Hector S. Villasano on 6/10/20.
//  Copyright © 2020 s. All rights reserved.
//

#import "HSVLeagueCardsTableViewController.h"
#import "HSVLeagueCardTableViewCell.h"
#import "HSVPokemonController.h"
#import "HSVSubmitLeagueCardNumberViewController.h"
#import "NationalGalarPokedex-Swift.h"
#import "HSVLeageCard.h"
#import "HSVSubmitLeagueCardNumberViewController.h"
#import <CloudKit/CloudKit.h>

@interface HSVLeagueCardsTableViewController ()
@property (nonatomic) HSVPokemonController *pokemonController;
@property (nonatomic) UIRefreshControl *refreshControl;
@property (nonatomic) HSVCloudFramework *cloudFramework;
@property (nonatomic, copy) NSArray<HSVLeageCard *> *internalCards;

@end

@implementation HSVLeagueCardsTableViewController
@synthesize refreshControl;

- (void)viewDidLoad {
    [super viewDidLoad];

    [self configureViews];
}

- (void)configureViews {
    self.pokemonController = HSVPokemonController.sharedPokemonController;
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

        NSArray<NSString *> *oldLeageCards = [self.pokemonController oldLeageCardList];
        NSMutableArray *cards = [NSMutableArray array];

        for (CKRecord *record in records) {
            NSString *recordName = record.recordID.recordName;
            NSString *cardID = (NSString *)[record objectForKey:@"cardID"];
            BOOL isOld = [oldLeageCards containsObject:recordName];

            HSVLeageCard *leageCard = [[HSVLeageCard new] initWithCardID:cardID isOld:isOld recordName:recordName];
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
    } else if ( [segue.identifier isEqualToString:@"AddLeagueCardSegue"]) {
        HSVSubmitLeagueCardNumberViewController *submitVC = (HSVSubmitLeagueCardNumberViewController *)segue.destinationViewController;
        submitVC.cards = self.internalCards;
    }
}

// MARK: - Table Vide Datasource


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 72;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_internalCards count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HSVLeagueCardTableViewCell *cell = (HSVLeagueCardTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"LeagueCardCell" forIndexPath:indexPath];

    HSVLeageCard *leageCard = [_internalCards objectAtIndex:indexPath.row];
    cell.leageCard = leageCard;
    [cell configureViews];
    cell.delegate = self;
    return  cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Leage Cards";
}

// MARK: - HSVLeagueCardTableViewCellDelegate

- (void)checkedButtonPressed:(BOOL)isOld recordName:(NSString *)recordName {

    dispatch_async(dispatch_get_main_queue(), ^{
        if (!isOld) {
            [self.pokemonController addOldLeageCard:recordName];
        } else {
            [self.pokemonController deleteOldLeageCard:recordName];
        }
        [self.tableView reloadData];
    });

}


@end
