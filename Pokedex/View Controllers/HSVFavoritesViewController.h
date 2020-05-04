//
//  HSVFavoritesViewController.h
//  Pokedex
//
//  Created by Hector S. Villasano on 4/28/20.
//  Copyright © 2020 s. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HSVPokemonControllerProtocol.h"


@class HSVPokemonController;

NS_ASSUME_NONNULL_BEGIN

@interface HSVFavoritesViewController : UIViewController<HSVPokemonControllerProtocol, UICollectionViewDataSource>

@property (nonatomic) HSVPokemonController *pokemonController;

@end

NS_ASSUME_NONNULL_END
