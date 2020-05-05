//
//  HSVPokemonDetailViewViewController.h
//  Pokedex
//
//  Created by Hector S. Villasano on 5/4/20.
//  Copyright © 2020 s. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HSVPokemon;

NS_ASSUME_NONNULL_BEGIN

@interface HSVPokemonDetailViewController : UIViewController<UITableViewDataSource>

@property (nonatomic) HSVPokemon *pokemon;

@end

NS_ASSUME_NONNULL_END
