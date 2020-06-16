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
#import "HSVSubmitLeagueCardNumberViewController.h"
#import <CloudKit/CloudKit.h>

@interface HSVLeagueCardsTableViewController ()

@property (nonatomic) HSVCloudFramework *cloudFramework;
@property (nonatomic, copy) NSArray<NSString *> *internalCards;

@end

@implementation HSVLeagueCardsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self createActivityIndicator];
    self.internalCards = [NSMutableArray array];
    self.cloudFramework = [HSVCloudFramework new];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self fetchLeageCards];
}

- (void)createActivityIndicator {
    self.activityIndicator = [UIActivityIndicatorView new];
    [self.activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleLarge];
    self.activityIndicator.hidesWhenStopped = true;
    self.tableView.backgroundView = self.activityIndicator;
}

- (void) fetchLeageCards {
    [self.activityIndicator startAnimating];

    [self.cloudFramework fetchRecordsWithRecordType:@"LeageCardID" completion:^(NSArray<CKRecord *> *records, NSError *error) {
        if (error != nil) {
            NSLog(@"%@", error.localizedDescription);
            return;
        }

        NSMutableArray *cards = [NSMutableArray array];
        for (CKRecord *record in records) {
            NSString *cardID = (NSString *)[record objectForKey:@"cardID"];
            [cards addObject:cardID];
        }

        self.internalCards = cards;

        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            [self.activityIndicator stopAnimating];
        });

    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@""]) {

    }
}

// MARK: Table Vide Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_internalCards count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HSVLeagueCardTableViewCell *cell = (HSVLeagueCardTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"LeagueCardCell" forIndexPath:indexPath];

    NSString *card = [_internalCards objectAtIndex:indexPath.row];

    cell.card = card;

    cell.cardCodeLabel.text = card;
    return  cell;
}

@end
