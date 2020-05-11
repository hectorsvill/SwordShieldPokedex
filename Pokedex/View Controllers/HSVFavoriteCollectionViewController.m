//
//  HSVFavoriteCollectionViewController.m
//  Pokedex
//
//  Created by Hector S. Villasano on 5/8/20.
//  Copyright © 2020 s. All rights reserved.
//

#import "HSVFavoriteCollectionViewController.h"
#import "HSVPokemonController.h"
#import "HSVPokemon.h"
#import "HSVFavoriteCollectionViewCell.h"
#import "NSString+HSVPokemonIndexString.h"
#import "HSVPokemonDetailViewController.h"

@interface HSVFavoriteCollectionViewController ()

@property (nonatomic, copy) NSArray *favoriteIndexList;

@end

@implementation HSVFavoriteCollectionViewController

static NSString * const reuseIdentifier = @"FavoriteCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.delegate = self;
    self.pokemonController = HSVPokemonController.sharedPokemonController;
    self.favoriteIndexList = [self.pokemonController fetchFavorites];
    [self.collectionView reloadData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"view will appear");
    self.favoriteIndexList = [self.pokemonController fetchFavorites];
    [self.collectionView reloadData];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

    if ([segue.identifier isEqualToString:@"FavoriteSegue"]) {
        HSVFavoriteCollectionViewCell *cell = (HSVFavoriteCollectionViewCell *)sender;
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
        HSVPokemon *pokemon = [_pokemonController fetchNationalDexpokemonWithIndex:_favoriteIndexList[indexPath.row]];

        HSVPokemonDetailViewController *destination = (HSVPokemonDetailViewController *)[segue destinationViewController];
        destination.pokemon = pokemon;
    }

}

#pragma mark <UICollectionViewDataSource>


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_favoriteIndexList count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HSVFavoriteCollectionViewCell *cell = (HSVFavoriteCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    NSNumber *pokemonIndex = [_favoriteIndexList objectAtIndex:indexPath.row];
    HSVPokemon *pokemon = [_pokemonController fetchNationalDexpokemonWithIndex:pokemonIndex];

    NSString *indexString = [[NSString new] HSVCreatePokemonIndexString:pokemon.national_dex.intValue];
    cell.pokemonImageView.image =  [UIImage imageNamed:indexString];
    cell.nameLabel.text = pokemon.name;
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(16, 16, 16, 16);
}



#pragma mark <UICollectionViewDelegate>


@end
