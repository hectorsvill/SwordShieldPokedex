//
//  HSVPokemonDetailViewViewController.m
//  Pokedex
//
//  Created by Hector S. Villasano on 5/4/20.
//  Copyright © 2020 s. All rights reserved.
//

#import "HSVSerebiiViewController.h"
#import "HSVPokemonDetailViewController.h"
#import "HSVPokemon.h"
#import "NSString+HSVPokemonIndexString.h"
#import <AVFoundation/AVFoundation.h>

@interface HSVPokemonDetailViewController ()

@property (nonatomic) AVSpeechSynthesizer *speechSynthesizer;
@property (weak, nonatomic) IBOutlet UIImageView *pokemonImageView;
@property (weak, nonatomic) IBOutlet UIImageView *shinyPokemonImageView;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSMutableDictionary<NSNumber *, NSMutableArray *> *pokemonData;
@property (nonatomic) NSArray *pokemonDescriptionSrtings;
@end

@implementation HSVPokemonDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureViews];
    [self setPokemonData];

    for (int i = 0; i <= _pokemonDescriptionSrtings.count; i++)
        [self configurePokemonDataWithSection:i];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    [_speechSynthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
    
}

#pragma mark -
- (void)configureViews
{
    self.speechSynthesizer = [[AVSpeechSynthesizer alloc] init];

    self.title = [NSString stringWithFormat:@"%@", _pokemon.name ];
    
    [self.navigationController.navigationBar setAccessibilityIdentifier: [NSString stringWithFormat:@"%@DetailView", _pokemon.name ]];
    [self.navigationItem.backBarButtonItem setIsAccessibilityElement:true];
    [self.navigationItem.backBarButtonItem setAccessibilityIdentifier:@"NavigationBackButton"];
    
    NSString *str = [[NSString new] HSVCreatePokemonIndexString:_pokemon.national_dex.intValue];
    _pokemonImageView.image = [UIImage imageNamed:str];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@.png", @"https://www.serebii.net/Shiny/SWSH/", str];
    NSURL *url = [NSURL URLWithString:urlString];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"%@", error.localizedDescription);
        }
        
        if (data) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.shinyPokemonImageView.image = [UIImage imageWithData:data];

            });
        }
    }] resume];
}

- (void)setPokemonData
{
    _pokemonDescriptionSrtings =  @[
         @"Description",
         @"NO.",
         @"Type",
         @"Height & Weight",
         @"Base Stats",
         @"Hatch Cycles",
         @"Exp Group",
         @"Egg groups",
         @"Egg Moves",
         @"Abilities",
         @"Level Up Moves",

     ];

    _pokemonData = [NSMutableDictionary dictionary];
    for (int i = 0; i < _pokemonDescriptionSrtings.count; i++)
        [_pokemonData addEntriesFromDictionary:@{[NSNumber numberWithInt:i]: [NSMutableArray array]}];

}

- (void)setpokemonDataWithSection:(NSInteger)sectionInt
{
    NSArray *data = _pokemonData[[NSNumber numberWithInteger:sectionInt]];
    NSMutableArray *indexPaths = [NSMutableArray array];

    for (int i = 0; i < data.count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:sectionInt];
        [indexPaths addObject:indexPath];
    }

    [_tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)configurePokemonDataWithSection:(NSInteger)section
{
    NSNumber *sectionIndexNumber = [NSNumber numberWithInteger:section];

    if (_pokemonData[sectionIndexNumber].count == 0) {
        switch ([sectionIndexNumber intValue]) {
            case 0:{
                [_pokemonData[sectionIndexNumber] addObject:_pokemon.pokedexdescription];
                break;
            }
            case 1:{
                NSString *nationalDexString = [NSString stringWithFormat:@"National:  #%@", _pokemon.national_dex];
                NSString *galarDexString = [NSString stringWithFormat:@"    Galar:  #%@", _pokemon.galar_dex];
                NSArray *dexArr = @[nationalDexString, galarDexString];
                [_pokemonData[sectionIndexNumber] addObjectsFromArray:dexArr];
                break;
            }
            case 2:{
                [_pokemonData[sectionIndexNumber] addObjectsFromArray:_pokemon.types];
                break;
            }
            case 3:{
                NSString *heightString = [NSString stringWithFormat:@"Height:  %@m", _pokemon.height];
                NSString *weightString = [NSString stringWithFormat:@"Weight:  %@kg", _pokemon.weight];
                NSArray *arr = @[heightString, weightString];
                [_pokemonData[sectionIndexNumber] addObjectsFromArray:arr];
                break;
            }
            case 4:{
                NSNumber *total = [_pokemon.base_stats valueForKeyPath:@"@sum.self"];
                NSString *totalString =      [NSString stringWithFormat:@"     TOTAL:  %@", total];
                NSString *baseString =      [NSString stringWithFormat:@"         HP:  %@", _pokemon.base_stats[0]];
                NSString *attackString =    [NSString stringWithFormat:@"     ATTACK:  %@", _pokemon.base_stats[1]];
                NSString *defenceString =   [NSString stringWithFormat:@"    DEFENSE:  %@", _pokemon.base_stats[2]];
                NSString *spAttackString =  [NSString stringWithFormat:@" Sp. ATTACK:  %@", _pokemon.base_stats[3]];
                NSString *spDefenceString = [NSString stringWithFormat:@"Sp. DEFENSE:  %@", _pokemon.base_stats[4]];
                NSString *speedString =     [NSString stringWithFormat:@"      Speed:  %@", _pokemon.base_stats[5]];

                NSArray *arr = @[totalString, baseString, attackString, defenceString, spAttackString, spDefenceString, speedString];
                [_pokemonData[sectionIndexNumber] addObjectsFromArray:arr];
                break;
            }
            case 5:{
                NSString *hatchCycleString =  [NSString stringWithFormat:@" Hatch Cycle:  %@", _pokemon.hatch_cycles];
                [_pokemonData[sectionIndexNumber] addObjectsFromArray:@[hatchCycleString]];
                break;
            }
            case 6:{
                NSString *expGroupString =  [NSString stringWithFormat:@"%@", _pokemon.exp_groups];
                [_pokemonData[sectionIndexNumber] addObjectsFromArray:@[expGroupString]];
                break;
            }
            case 7:{
                [_pokemonData[sectionIndexNumber] addObjectsFromArray:_pokemon.egg_groups];
                break;
            }
            case 8:{
                [_pokemonData[sectionIndexNumber] addObjectsFromArray:_pokemon.egg_moves];

                break;
            }
            case 9:{
                [_pokemonData[sectionIndexNumber] addObjectsFromArray:_pokemon.abilities];
                break;
            }
            case 10: {
                NSArray *level_up_moves = _pokemon.level_up_moves;
                NSMutableArray<NSString *> *level_up_movesStringArray = [NSMutableArray array];

                for (int i = 0; i < level_up_moves.count; i++) {
                    NSArray *arr = [level_up_moves objectAtIndex:i];

                    NSString *level_up_moveString = [NSString stringWithFormat:@"lvl.%@\t %@", [NSNumber numberWithLong: [arr[0] integerValue]] , arr[1]];
                    [level_up_movesStringArray addObject:level_up_moveString];
                }

                [_pokemonData[sectionIndexNumber] addObjectsFromArray:level_up_movesStringArray];

                break;
            }
            default:
                break;
        };

        [self setpokemonDataWithSection:sectionIndexNumber.integerValue];
    } else {

        NSInteger rowCount = _pokemonData[sectionIndexNumber].count;
        NSMutableArray *indexPaths = [NSMutableArray array];

        [_pokemonData[sectionIndexNumber] removeAllObjects];
        
        for (int i = 0; i < rowCount; i++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:sectionIndexNumber.integerValue];
            [indexPaths addObject:indexPath];
        }

        [_tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"SerebiiSegue"]) {
        HSVSerebiiViewController *serebiiVC = (HSVSerebiiViewController *)segue.destinationViewController;
        serebiiVC.pokemonName = [_pokemon.name lowercaseString];
    }
}

#pragma mark - headerButtonClicked
- (void)headerButtonClicked:(UIButton *)sender
{
    [self configurePokemonDataWithSection:sender.tag];
}

#pragma mark - pokedexSpeak
- (void)pokedexSpeak:(HSVPokemon *)pokemon
{
    NSString *typeString = [pokemon.types componentsJoinedByString:@" and "];
    NSString *UtteranceString = [NSString stringWithFormat:@"%@. %@ type. %@", pokemon.name, typeString, pokemon.pokedexdescription];
    AVSpeechUtterance *speechUtterance = [AVSpeechUtterance speechUtteranceWithString:UtteranceString];
    speechUtterance.voice = [AVSpeechSynthesisVoice voiceWithIdentifier:@"com.apple.ttsbundle.siri_male_en-GB_compact"];
    [_speechSynthesizer speakUtterance:speechUtterance];
}

#pragma mark - playButtonPressed
- (IBAction)playButtonPressed:(id)sender
{
    [_speechSynthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
    [self pokedexSpeak:_pokemon];
}

#pragma mark - Table View
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIButton *button = [UIButton new];
    [button setTag:section];
    button.layer.cornerRadius = 3;
    button.backgroundColor = UIColor.systemGray6Color;
    [button setTitleColor:UIColor.systemRedColor forState:UIControlStateNormal];
    [button setTitle:_pokemonDescriptionSrtings[section] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(headerButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [button setIsAccessibilityElement:true];
    NSString *buttonID = [NSString stringWithFormat:@"%@Button", _pokemonDescriptionSrtings[section]];
    [button setAccessibilityIdentifier:buttonID];
    return button;

}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{

    return [NSString stringWithFormat:@"%ld", (long)section];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _pokemonData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_pokemonData objectForKey:[NSNumber numberWithInteger:section]].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailCell" forIndexPath:indexPath];

    NSString *text = _pokemonData[[NSNumber numberWithUnsignedLong:indexPath.section]][indexPath.row];
    cell.textLabel.text = text;
    [cell.textLabel setNumberOfLines:0];
    cell.textLabel.font = [UIFont systemFontOfSize:15];

    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_tableView deselectRowAtIndexPath:indexPath animated:true];
}

@end
