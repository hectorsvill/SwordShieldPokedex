//
//  HSVPokemonTableViewCell.h
//  Pokedex
//
//  Created by s on 4/22/20.
//  Copyright © 2020 s. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HSVPokemonTableViewCellDelegate.h"
@class HSVPokemon;

NS_ASSUME_NONNULL_BEGIN

@interface HSVPokemonTableViewCell : UITableViewCell

@property (nonatomic, copy) NSString *indexString;
@property HSVPokemon *pokemon;
@property (weak, nonatomic) IBOutlet UILabel *indexLabel;
@property (weak, nonatomic) IBOutlet UIImageView *pokemonImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;
@property (weak, nonatomic) NSNumber  *isFavorite;

- (IBAction)favoriteButtonPressed:(id)sender;
- (void)setupViews;

@property (weak) id<HSVPokemonTableViewCellDelegate> delegate;

//@property Pokedex pokdexType;
@end

NS_ASSUME_NONNULL_END
