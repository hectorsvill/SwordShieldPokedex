//
//  HSVPokemonTableViewCell.h
//  Pokedex
//
//  Created by s on 4/22/20.
//  Copyright © 2020 s. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HSVPokemon;

NS_ASSUME_NONNULL_BEGIN

@interface HSVPokemonTableViewCell : UITableViewCell

@property HSVPokemon *pokemon;
@property (weak, nonatomic) IBOutlet UILabel *indexLabel;
@property (weak, nonatomic) IBOutlet UIImageView *pokemonImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;
@property BOOL isFavorite;

- (IBAction)favoriteButtonPressed:(id)sender;
- (void)setupViews;

@end

NS_ASSUME_NONNULL_END
