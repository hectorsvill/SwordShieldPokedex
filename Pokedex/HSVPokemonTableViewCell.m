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

- (void)setupViews {
    _indexString = [[NSString new] HSVCreatePokemonIndexString: _pokdexType == Galar ? _pokemon.galar_dex.intValue : _pokemon.national_dex.intValue];
    [[self favoriteButton] setTintColor: [UIColor systemRedColor]];
    _indexLabel.text = [NSString stringWithFormat:@"#%@", _indexString];
    _nameLabel.text = [[_pokemon name] capitalizedString];
    NSString *imageName = [[NSString new] HSVCreatePokemonIndexString: _pokemon.national_dex.intValue];
    _pokemonImageView.image = [UIImage imageNamed: imageName];
    [self setFavoriteButtonImage];
}

- (IBAction)favoriteButtonPressed:(id)sender {
    _isFavorite = [_isFavorite isEqualToNumber:@YES] ? @NO : @YES;
    if ([_delegate conformsToProtocol:@protocol(HSVPokemonTableViewCellDelegate) ])
        [_isFavorite isEqualToNumber:@YES] ? [_delegate saveToFavorites:_pokemon.national_dex] : [_delegate removefromFavorites:_pokemon.national_dex];

    [self setFavoriteButtonImage];
}

- (void)setFavoriteButtonImage {
    NSString *imageName = [_isFavorite isEqualToNumber:@YES] ? @"heart.fill" : @"heart";
    UIImage *image = [UIImage systemImageNamed:imageName];
    [_favoriteButton setImage:image forState:UIControlStateNormal];
}


@end
