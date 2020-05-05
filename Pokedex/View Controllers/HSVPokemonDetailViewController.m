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

@end

@implementation HSVPokemonDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureViews];

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    [_speechSynthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
}

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


- (void)pokedexSpeak:(HSVPokemon *)pokemon
{
    NSString *typeString = [pokemon.types componentsJoinedByString:@" and "];
    NSString *UtteranceString = [NSString stringWithFormat:@"%@. %@ type. %@", pokemon.name, typeString, pokemon.pokedexdescription];
    AVSpeechUtterance *speechUtterance = [AVSpeechUtterance speechUtteranceWithString:UtteranceString];
    speechUtterance.voice = [AVSpeechSynthesisVoice voiceWithIdentifier:@"com.apple.ttsbundle.siri_male_en-GB_compact"];
    [_speechSynthesizer speakUtterance:speechUtterance];
}

- (IBAction)playButtonPressed:(id)sender
{
    [_speechSynthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
    [self pokedexSpeak:_pokemon];
}

#pragma mark - Table view data source

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{

    return [NSString stringWithFormat:@"%ld", (long)section ];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailCell" forIndexPath:indexPath];

    cell.textLabel.text = @"text";

    cell.detailTextLabel.text = @"detail";

    return cell;
}

@end
