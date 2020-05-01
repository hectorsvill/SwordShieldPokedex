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

@interface SearchTableViewController ()

@property (nonatomic) UISearchBar *searchBar;
@property (nonatomic, copy) NSArray<NSNumber *> *pokemonIndexList;
@property (nonatomic) AVSpeechSynthesizer *speechSynthesizer;

@end

@implementation SearchTableViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.pokemonController = HSVPokemonController.sharedPokemonController;
    [self setupViews];
}

- (void)setupViews
{
    self.speechSynthesizer = [[AVSpeechSynthesizer alloc] init];
    [self setPokemonSearchBar];
    [self createNavigationSearchBar];

    [self tableView].rowHeight = 80;

    [_pokemonController fetchPokemonData:^(NSArray<NSNumber *> *pokemonIndexList) {
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

    UIImage *gearImage = [UIImage systemImageNamed:@"gear"];
    [self navigationItem].leftBarButtonItem = [[UIBarButtonItem new] initWithImage:gearImage style:UIBarButtonItemStyleDone target:self action:@selector(gearButtonPressed)];
    [self navigationItem].leftBarButtonItem.tintColor = [UIColor systemRedColor];

}

- (void)gearButtonPressed
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Pokedex NO." message:NULL preferredStyle:UIAlertControllerStyleActionSheet];

    // galar dex
    UIAlertAction *galarDexAction = [UIAlertAction actionWithTitle:@"Galar Pokedex" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        dispatch_async(dispatch_get_main_queue(), ^{
            self.pokemonIndexList = nil;
            [self.tableView reloadData];
        });
    }];

    [alertController addAction:galarDexAction];

    // national dex
    UIAlertAction *nationalDexAction = [UIAlertAction actionWithTitle:@"National Pokedex" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        dispatch_async(dispatch_get_main_queue(), ^{
            self.pokemonIndexList = [self.pokemonController pokemonIndexList];
            [self.tableView reloadData];
        });
    }];

    [alertController addAction:nationalDexAction];


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

- (void)pokedexSpeak:(HSVPokemon *)pokemon
{
    NSString *typeString = [pokemon.types componentsJoinedByString:@" and "];
    NSString *UtteranceString = [NSString stringWithFormat:@"%@. %@ type. %@", pokemon.name, typeString, pokemon.pokedexdescription];
    AVSpeechUtterance *speechUtterance = [AVSpeechUtterance speechUtteranceWithString:UtteranceString];
    speechUtterance.voice = [AVSpeechSynthesisVoice voiceWithIdentifier:@"com.apple.ttsbundle.siri_male_en-GB_compact"];
    [_speechSynthesizer speakUtterance:speechUtterance];
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
    HSVPokemon *pokemon = [_pokemonController fetchNationalDexpokemonWithIndex:[NSNumber numberWithLong:pokemonIndex.longValue]];
    cell.pokemon = pokemon;
    cell.isFavorite = [_pokemonController isfavortie:pokemonIndex];
    cell.delegate = self;
    [cell setupViews];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:true];

    [_speechSynthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
    HSVPokemonTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    HSVPokemon *pokemon = cell.pokemon;

//    [self pokedexSpeak:pokemon];
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
        NSArray *pokemonIndexList = [_pokemonController filterWithString:text];
        self.pokemonIndexList = pokemonIndexList;
    } else {
        self.pokemonIndexList = [_pokemonController pokemonIndexList];
    }

    [[self tableView] reloadData];
}

#pragma mark - HSVPOkemonTableViewCellDelegate

- (void)saveToFavorites:(NSNumber *)indexNumber
{
    [self.pokemonController addFavorite: indexNumber];
    NSLog(@"%lu", (unsigned long)self.pokemonController.fetchFavorites.count);
}

@end
