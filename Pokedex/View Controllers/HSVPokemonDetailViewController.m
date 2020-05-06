//
//  HSVPokemonDetailViewViewController.m
//  Pokedex
//
//  Created by Hector S. Villasano on 5/4/20.
//  Copyright © 2020 s. All rights reserved.
//

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
@property (nonatomic) NSDictionary<NSNumber *, NSMutableArray *> *pokemonData;
@property (nonatomic) NSArray *pokemonDescriptionSrtings;
@end

@implementation HSVPokemonDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureViews];
    [self setPokemonData];
    [self configurePokemonDataWithSection:0];
    [self configurePokemonDataWithSection:1];
    [self configurePokemonDataWithSection:2];
    [self configurePokemonDataWithSection:3];
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
         @"Decription",
         @"NO.",
         @"Type",
         @"Height & Weight",
         @"Base Stats",
     ];

    _pokemonData = @{
        @0: [NSMutableArray array],
        @1: [NSMutableArray array],
        @2: [NSMutableArray array],
        @3: [NSMutableArray array],
        @3: [NSMutableArray array],
    };
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
    return 44;
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
    cell.textLabel.font = [UIFont systemFontOfSize:12];

    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_tableView deselectRowAtIndexPath:indexPath animated:true];
}

@end
