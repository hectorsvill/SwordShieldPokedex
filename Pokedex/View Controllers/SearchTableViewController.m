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
//#import <QuartzCore/QuartzCore.h>

@interface SearchTableViewController ()

@property (nonatomic) UISearchBar *searchBar;
@property (nonatomic, copy) HSVPokemonController *pekemonController;
@property (nonatomic, copy) NSArray<NSNumber *> *pokemonIndexList;
@property (nonatomic, copy) AVSpeechSynthesizer *speechSynthesizer;

@end

@implementation SearchTableViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupViews];
}

- (void)setupViews
{
    _speechSynthesizer = [[AVSpeechSynthesizer alloc] init];
    UISearchBar *searchBar = [[UISearchBar new] initWithFrame:CGRectZero];
    [searchBar setTintColor:[UIColor systemRedColor]];
    [searchBar setPlaceholder:@"Search..."];
    [searchBar setDelegate: self];

    _searchBar = searchBar;
    [self createNavigationSearchBar];
    [self tableView].rowHeight = 80;
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
    [self navigationItem].rightBarButtonItem.tintColor = [UIColor systemRedColor];
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
            self.pokemonIndexList = [_pekemonController pokemonIndexList];
            [[self tableView] reloadData];
        }
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
    HSVPokemon *pokemon = [_pekemonController fetchpokemonWithIndex:[NSNumber numberWithLong:pokemonIndex.longValue]];
    cell.pokemon = pokemon;
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
    [self pokedexSpeak:pokemon];
}

- (void)pokedexSpeak:(HSVPokemon *)pokemon
{
    NSString *UtteranceString = [NSString stringWithFormat:@"%@.  %@", pokemon.name, pokemon.pokedexdescription];
    AVSpeechUtterance *speechUtterance = [AVSpeechUtterance speechUtteranceWithString:UtteranceString];
    speechUtterance.voice = [AVSpeechSynthesisVoice voiceWithIdentifier:@"com.apple.ttsbundle.siri_male_en-GB_compact"];
    [_speechSynthesizer speakUtterance:speechUtterance];
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
        NSArray *pokemonIndexList = [_pekemonController filterWithString:text];
        self.pokemonIndexList = pokemonIndexList;
    } else {
        self.pokemonIndexList = [_pekemonController pokemonIndexList];
    }

    [[self tableView] reloadData];
}

@end
