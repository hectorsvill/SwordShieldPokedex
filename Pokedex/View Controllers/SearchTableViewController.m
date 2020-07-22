//
//  SearchTableViewController.m
//  Pokedex
//
//  Created by s on 4/22/20.
//  Copyright © 2020 s. All rights reserved.
//

#import "SearchTableViewController.h"
#import "HSVPokemon.h"
#import "HSVPokemonTableViewCell.h"
#import "NSString+HSVPokemonIndexString.h"
#import "HSVPokemonController.h"
#import <AVFoundation/AVFoundation.h>
#import "HSVPokemonDetailViewController.h"
#import "HSVPokedex_Type.h"


@interface SearchTableViewController ()

@property (nonatomic) enum Pokedex pokedexType;
@property (nonatomic) UISearchBar *searchBar;
@property (nonatomic, copy) NSArray<NSNumber *> *pokemonIndexList;


@end

@implementation SearchTableViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.pokemonController = HSVPokemonController.sharedPokemonController;

    _pokedexType = National;

    [self configureAccessibility];
    [self setupViews];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setAccessibilityIdentifier:@"PokedexSearchNavigationBar"];
}

- (void)configureAccessibility
{
    self.navigationController.isAccessibilityElement = true;
    
    self.navigationController.navigationBar.isAccessibilityElement = true;
    [self.navigationController.navigationBar setAccessibilityIdentifier:@"PokedexSearchNavigationBar"];
    
    [self.tableView setIsAccessibilityElement:true];
    [self.tableView setAccessibilityIdentifier:@"PokedexListTableView"];
    
}

- (void)setupViews
{
    [self setPokemonSearchBar];
    [self createNavigationSearchBar];

    [_pokemonController fetchPokemonDataFromJson:^(NSArray<NSNumber *> *pokemonIndexList) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self->_pokemonIndexList = pokemonIndexList;
            [[self tableView] reloadData];
        });
    }];
}

- (void)setPokemonSearchBar
{
    self.searchBar = [[UISearchBar new] initWithFrame:CGRectZero];
    [_searchBar setTintColor:[UIColor systemRedColor]];
    [_searchBar setPlaceholder:@"Search..."];
    [_searchBar setDelegate: self];
}

- (void)createNavigationSearchBar
{
    UIImage *magnifyingglassImage = [UIImage systemImageNamed:@"magnifyingglass"];
    [self navigationItem].rightBarButtonItem = [[UIBarButtonItem new] initWithImage:magnifyingglassImage style:UIBarButtonItemStyleDone target:self action:@selector(searchBarPressed)];
    [self navigationItem].rightBarButtonItem.tintColor = [UIColor systemRedColor];
    [[self navigationItem].rightBarButtonItem setIsAccessibilityElement:true];
    [[self navigationItem].rightBarButtonItem setAccessibilityIdentifier:@"rightBarButtonItemMagnifyingglass"];

    UIImage *gearImage = [UIImage systemImageNamed:@"gear"];
    [self navigationItem].leftBarButtonItem = [[UIBarButtonItem new] initWithImage:gearImage style:UIBarButtonItemStyleDone target:self action:@selector(gearButtonPressed)];
    [self navigationItem].leftBarButtonItem.tintColor = [UIColor systemRedColor];
    [[self navigationItem].leftBarButtonItem setIsAccessibilityElement:true];
    [[self navigationItem].leftBarButtonItem setAccessibilityIdentifier:@"leftBarButtonItemGear"];

}

// MARK: - gearButtonPressed
- (void)gearButtonPressed
{
    UIAlertControllerStyle alertStyle = ([[UIDevice currentDevice].model hasPrefix:@"iPhone"]) ? UIAlertControllerStyleActionSheet : UIAlertControllerStyleAlert;

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Pokedex NO." message:NULL preferredStyle:alertStyle];

    // galar dex
    UIAlertAction *galarDexAction = [UIAlertAction actionWithTitle:@"Galar Pokedex" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        dispatch_async(dispatch_get_main_queue(), ^{
            self.pokedexType = Galar;
            self.searchBar.text = @"";
            self.pokemonIndexList = [self.pokemonController fetchGalarDexIndexList];
            [self.tableView reloadData];
        });
    }];

    [alertController addAction:galarDexAction];

    // national dex
    UIAlertAction *nationalDexAction = [UIAlertAction actionWithTitle:@"National Pokedex" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        dispatch_async(dispatch_get_main_queue(), ^{
            self.pokedexType = National;
            self.searchBar.text = @"";
            self.pokemonIndexList = [self.pokemonController pokemonIndexList];
            [self.tableView reloadData];
        });
    }];

    [alertController addAction:nationalDexAction];


    UIAlertAction *favoriteDexAction = [UIAlertAction actionWithTitle:@"Favorite" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.pokedexType = Favorite;
            self.searchBar.text = @"";
            self.pokemonIndexList = [self.pokemonController fetchFavorites];
            [self.tableView reloadData];
        });
    }];

    [alertController addAction:favoriteDexAction];

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:NULL];
    [alertController addAction:cancelAction];

    [self presentViewController:alertController animated:YES completion:nil];

}



- (void)searchBarPressed
{
    UIView *titleView = [self navigationItem].titleView;
    [self navigationItem].titleView = (titleView == nil) ? [self searchBar] : nil;

    if (titleView == nil) {
        [self navigationItem].titleView = [self searchBar];

    } else {
        if ([self.pokemonIndexList count] == 0) {
            [self searchBar].text = @"";
            [self navigationItem].titleView = nil;
            self.pokemonIndexList = [_pokemonController pokemonIndexList];
            [[self tableView] reloadData];
        }
    }
}


#pragma mark - prepareForSegue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"PokemonDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSNumber *pokemonIndex = [_pokemonIndexList objectAtIndex:indexPath.row];
        HSVPokemon *pokemon = _pokedexType == Galar ? [_pokemonController fetchGalarDexpokemonWithIndex:[NSNumber numberWithLong:pokemonIndex.longValue]] : [_pokemonController fetchNationalDexpokemonWithIndex:[NSNumber numberWithLong:pokemonIndex.longValue]];
        HSVPokemonDetailViewController *detailViewController = (HSVPokemonDetailViewController *)segue.destinationViewController;
        detailViewController.pokemon = pokemon;
    }
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_pokemonIndexList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HSVPokemonTableViewCell *cell = (HSVPokemonTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"SearchCell" forIndexPath:indexPath];
    NSNumber *pokemonIndex = [_pokemonIndexList objectAtIndex:indexPath.row];
    HSVPokemon *pokemon = _pokedexType == Galar ? [_pokemonController fetchGalarDexpokemonWithIndex:[NSNumber numberWithLong:pokemonIndex.longValue]] : [_pokemonController fetchNationalDexpokemonWithIndex:[NSNumber numberWithLong:pokemonIndex.longValue]];
    cell.pokdexType = _pokedexType;
    cell.pokemon = pokemon;
    cell.isFavorite = [_pokemonController isfavortie:pokemon.national_dex];
    cell.delegate = self;
    [cell setupViews];
    
    cell.isAccessibilityElement = true;
    cell.accessibilityIdentifier = [NSString stringWithFormat:@"%@Cell", pokemon.name];
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_searchBar resignFirstResponder];
}

#pragma mark - Search bar delegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if ([searchBar.text length] > 0) {
        NSString *text = [searchBar.text lowercaseString];
        NSArray<NSNumber *> *pokemonIndexList = [_pokemonController filterWithString:text dictionary: _pokedexType == Galar ? self.pokemonController.galarDexDictionary : self.pokemonController.nationalDexDictionary pokedex_type:_pokedexType];
        self.pokemonIndexList = pokemonIndexList;

    } else {
        self.pokemonIndexList = [_pokemonController pokemonIndexList];
    }

    [[self tableView] reloadData];
}

#pragma mark - HSVPOkemonTableViewCellDelegate
- (void)saveToFavorites:(NSNumber *)number
{
    [self.pokemonController addFavorite: number];

    if (self.pokedexType == Favorite)
        dispatch_async(dispatch_get_main_queue(), ^{
            self.pokemonIndexList = [self.pokemonController fetchFavorites];
            [self.tableView reloadData];
        });
}

- (void)removefromFavorites:(NSNumber *)number
{
    [self.pokemonController removeInternalFavoritePokemon:number];

    if (self.pokedexType == Favorite)
        dispatch_async(dispatch_get_main_queue(), ^{
            self.pokemonIndexList = [self.pokemonController fetchFavorites];
            [self.tableView reloadData];
        });
}

@end
