//
//  HSVFavoriteCollectionViewController.h
//  Pokedex
//
//  Created by Hector S. Villasano on 5/8/20.
//  Copyright © 2020 s. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HSVPokemonControllerProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface HSVFavoriteCollectionViewController : UICollectionViewController<HSVPokemonControllerProtocol>

@property (nonatomic) HSVPokemonController *pokemonController;

@end

NS_ASSUME_NONNULL_END
