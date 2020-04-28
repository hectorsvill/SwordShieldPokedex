//
//  HSVPokemonTableViewCell.m
//  Pokedex
//
//  Created by s on 4/22/20.
//  Copyright © 2020 s. All rights reserved.
//

#import "HSVPokemonTableViewCell.h"
#import "HSVPokemon.h"
#import "NSString+HSVPokemonIndexString.h"

@implementation HSVPokemonTableViewCell

- (void)setupViews
{
    [[self favoriteButton] setTintColor: [UIColor systemRedColor]];
    NSString *indexString = [[NSString new] HSVCreatePokemonIndexString:_pokemon.pokemonID.intValue];
    _indexLabel.text = [NSString stringWithFormat:@"#%@", indexString];
    _nameLabel.text = [[_pokemon name] capitalizedString];
    _pokemonImageView.image = [UIImage imageNamed:indexString];
//    [self setFavoriteButtonImage];
}

- (IBAction)favoriteButtonPressed:(id)sender
{
    [_delegate saveToFavorites:_pokemon.pokemonID];
//    _isFavorite = [_isFavorite isEqualToNumber:@YES] ? @NO : @YES;
//    [self setFavoriteButtonImage];
}

- (void)setFavoriteButtonImage
{
//    NSString *imageName = [_isFavorite isEqualToNumber:@YES] ? @"heart.fill" : @"heart";
//    UIImage *image = [UIImage systemImageNamed:imageName];
//    [_favoriteButton setImage:image forState:UIControlStateNormal];
}


@end
