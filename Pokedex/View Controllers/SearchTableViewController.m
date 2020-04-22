//
//  SearchTableViewController.m
//  Pokedex
//
//  Created by s on 4/22/20.
//  Copyright © 2020 s. All rights reserved.
//

#import "SearchTableViewController.h"

@interface SearchTableViewController ()

@property (nonatomic, copy) NSArray *pokemon;

@end

@implementation SearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self tableView].rowHeight = 70;
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_pokemon count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchCell" forIndexPath:indexPath];

    

    cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}

@end
