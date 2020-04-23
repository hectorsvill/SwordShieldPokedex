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

//@property (nonatomic, copy) HSVNetworking *networking;
@property (nonatomic, copy) HSVPokemonController *pekemonController;
//@property (nonatomic, readonly, copy) NSArray<HSVPokemon *> *pokemonList;

@end

@implementation SearchTableViewController
- (void)viewDidLoad
{
    [super viewDidLoad];

    [self tableView].rowHeight = 70;
//    _networking = [HSVNetworking new];
//    [self fetchPokemonList];

    _pekemonController = [HSVPokemonController new];
    [_pekemonController fetchPokemonData:^() {
        [[self tableView] reloadData];
    }];

}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_pekemonController pokemonListCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HSVPokemonTableViewCell *cell = (HSVPokemonTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"SearchCell" forIndexPath:indexPath];

    HSVPokemon *pokemon = [[_pekemonController pokemonList] objectAtIndex:indexPath.row];

    NSString *indexString = [[NSString new] HSVCreatePokemonIndexString:(int)indexPath.row + 1];
    cell.indexLabel.text = indexString;
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
