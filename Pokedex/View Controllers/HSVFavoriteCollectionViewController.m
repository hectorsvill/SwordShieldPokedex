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

@interface HSVFavoriteCollectionViewController ()

@property (nonatomic, copy) NSArray *favoriteIndexList;

@end

@implementation HSVFavoriteCollectionViewController

static NSString * const reuseIdentifier = @"FavoriteCell";

- (void)viewDidLoad {
    [super viewDidLoad];

    self.pokemonController = HSVPokemonController.sharedPokemonController;
    self.favoriteIndexList = [[self.pokemonController fetchFavorites] allObjects];

//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView reloadData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    self.favoriteIndexList = [[self.pokemonController fetchFavorites] allObjects];
    [self.collectionView reloadData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 2;//[_favoriteIndexList count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    [cell.layer setBorderWidth:2];
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(16, 16, 16, 16);
}

#pragma mark <UICollectionViewDelegate>


@end
