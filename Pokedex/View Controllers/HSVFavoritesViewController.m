//
//  HSVFavoritesViewController.m
//  Pokedex
//
//  Created by Hector S. Villasano on 4/28/20.
//  Copyright © 2020 s. All rights reserved.
//

#import "HSVFavoritesViewController.h"
#import "HSVPokemonController.h"
#import "HSVPokemon.h"
#import "HSVPokemonTableViewCell.h"

@interface HSVFavoritesViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, copy) NSArray *favoriteIndexList;

@end

@implementation HSVFavoritesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.pokemonController = HSVPokemonController.sharedPokemonController;
    self.tableView.rowHeight = 80;
    self.favoriteIndexList = [self.pokemonController fetchFavorites];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    self.favoriteIndexList = [self.pokemonController fetchFavorites];
    [self.tableView reloadData];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.favoriteIndexList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FavortieCell" forIndexPath:indexPath];

    NSNumber *favoriteIndex = [self.favoriteIndexList objectAtIndex:indexPath.row];
    HSVPokemon *pokemon = [self.pokemonController fetchNationalDexpokemonWithIndex:favoriteIndex];
    cell.textLabel.text = pokemon.name;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;

    return cell;
}

#pragma mark - Table view delegate



- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{

}

@end
