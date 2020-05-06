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
@property (nonatomic) NSDictionary<NSNumber *, NSArray *> *pokemonData;
@property (nonatomic) NSArray *pokemonDescriptionSrtings;
@end

@implementation HSVPokemonDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureViews];
    [self setPokemonData];

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
         @"Height",
         @"Weight",
         @"Base Stats",
     ];

    _pokemonData = @{
        @0: @[_pokemon.pokedexdescription],
        @1: @[[NSString stringWithFormat:@"National: %@", _pokemon.national_dex], [NSString stringWithFormat:@"Galar: %@", _pokemon.galar_dex]],
        @2: @[],
        @3: @[],
        @4: @[],
        @5: @[]
    };
}

- (void)configurePokemonData:(NSInteger)section
{
    NSNumber *sectionNumber = [NSNumber numberWithInteger:section];

    if ([_pokemonData objectForKey: sectionNumber].count == 0) {



    } else {

        NSInteger rowCount = _pokemonData[sectionNumber].count;
        NSLog(@"%ld", (long)rowCount);
    }


}

#pragma mark - headerButtonClicked
- (void)headerButtonClicked:(UIButton *)sender
{
    [self configurePokemonData:sender.tag];


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
    button.layer.cornerRadius = 8;
    button.backgroundColor = UIColor.systemGroupedBackgroundColor;
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
    return cell;
}

@end
