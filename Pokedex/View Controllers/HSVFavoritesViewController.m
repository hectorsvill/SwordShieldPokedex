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
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, copy) NSArray *favoriteIndexList;

@end

@implementation HSVFavoritesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.pokemonController = HSVPokemonController.sharedPokemonController;
    self.favoriteIndexList = [[self.pokemonController fetchFavorites] allObjects];
    [_collectionView reloadData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    self.favoriteIndexList = [[self.pokemonController fetchFavorites] allObjects];
    [_collectionView reloadData];
}

//#pragma mark - Table view delegate

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FavoriteCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_favoriteIndexList count];
}


@end
