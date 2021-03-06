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
#import "HSVLeagueCard.h"
#import "HSVSubmitLeagueCardNumberViewController.h"
#import <CloudKit/CloudKit.h>

@interface HSVLeagueCardsTableViewController ()
@property (nonatomic) HSVPokemonController *pokemonController;
@property (nonatomic) UIRefreshControl *refreshControl;
@property (nonatomic) HSVCloudFramework *cloudFramework;
@property (nonatomic, copy) NSMutableArray<HSVLeagueCard *> *internalCards;

@end

@implementation HSVLeagueCardsTableViewController
@synthesize refreshControl;

- (void)viewDidLoad {
    [super viewDidLoad];

    [self configureViews];
    
    self.view.isAccessibilityElement = true;
    self.view.accessibilityIdentifier = @"LeagueCardsTableViewController";
}

- (void)configureViews {
    self.pokemonController = HSVPokemonController.sharedPokemonController;
    self.internalCards = [NSMutableArray array];
    self.cloudFramework = [HSVCloudFramework new];
    [self createRefreshControl];
    [self.refreshControl beginRefreshing];
    [self fetchLeageCards];

    #if DEBUG
    NSArray *arguments = [[NSProcessInfo processInfo] arguments];
    if ([arguments containsObject:@"enable-testing"]) {
        self.tableView.refreshControl = nil;
    }
    #endif
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

        NSArray<NSString *> *oldLeageCards = [self.pokemonController oldLeagueCardList];
        NSMutableArray *cards = [NSMutableArray array];

        for (CKRecord *record in records) {
            NSString *recordName = record.recordID.recordName;
            NSString *cardID = (NSString *)[record objectForKey:@"cardID"];
            BOOL isOld = [oldLeageCards containsObject:recordName];

            HSVLeagueCard *leageCard = [[HSVLeagueCard new] initWithCardID:cardID isOld:isOld recordName:recordName];
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
        submitVC.delegate = self;
    }
}

// MARK: - Table View Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 72;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_internalCards count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HSVLeagueCardTableViewCell *cell = (HSVLeagueCardTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"LeagueCardCell" forIndexPath:indexPath];

    HSVLeagueCard *leageCard = [_internalCards objectAtIndex:indexPath.row];
    cell.leagueCard = leageCard;
    [cell configureViews];
    cell.delegate = self;
    
    cell.isAccessibilityElement = true;
    cell.accessibilityIdentifier = leageCard.cardID;
    return  cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Leage Cards";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [self.tableView deselectRowAtIndexPath:indexPath animated:true];
}

# pragma mark: - HSVLeagueCardTableViewCellDelegate

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
