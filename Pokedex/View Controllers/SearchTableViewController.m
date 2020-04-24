//
//  SearchTableViewController.m
//  Pokedex
//
//  Created by s on 4/22/20.
//  Copyright © 2020 s. All rights reserved.
//

#import "SearchTableViewController.h"
//#import "HSVNetworking.h"
#import "HSVPokemon.h"
#import "HSVPokemonTableViewCell.h"
#import "NSString+HSVPokemonIndexString.h"
#import "HSVPokemonController.h"

@interface SearchTableViewController ()

@property (nonatomic, copy) HSVPokemonController *pekemonController;
@property (nonatomic, readonly, copy) NSArray<NSNumber *> *pokemonIndexList;

@end

@implementation SearchTableViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupViews];
}

- (void)setupViews
{
    [self createNavigationSearchBar];
    [self tableView].rowHeight = 70;
    _pekemonController = [HSVPokemonController new];

    [_pekemonController fetchPokemonData:^(NSArray<NSNumber *> *pokemonIndexList) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self->_pokemonIndexList = pokemonIndexList;
            [[self tableView] reloadData];
        });
    }];
}


- (void)createNavigationSearchBar
{
    UIImage *magnifyingglassImage = [UIImage systemImageNamed:@"magnifyingglass"];
    [self navigationItem].rightBarButtonItem = [[UIBarButtonItem new] initWithImage:magnifyingglassImage style:UIBarButtonItemStyleDone target:self action:@selector(searchBarPressed)];


}

- (void)searchBarPressed
{

    NSLog(@"search");

}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_pekemonController pokemonListCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HSVPokemonTableViewCell *cell = (HSVPokemonTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"SearchCell" forIndexPath:indexPath];

    NSNumber *pokemonIndex = [_pokemonIndexList objectAtIndex:indexPath.row];

    HSVPokemon *pokemon = [_pekemonController pokemonWithIndex:[NSNumber numberWithLong:pokemonIndex.longValue]];
    NSString *indexString = [[NSString new] HSVCreatePokemonIndexString:pokemonIndex.intValue];

    cell.indexLabel.text = [NSString stringWithFormat:@"#%@", indexString];
    cell.nameLabel.text = [[pokemon name] capitalizedString];
    cell.pokemonImageView.image = [UIImage imageNamed:indexString];

    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}

@end
