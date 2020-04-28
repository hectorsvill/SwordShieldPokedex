//
//  HSVPokemonTableViewCellDelegate.h
//  Pokedex
//
//  Created by Hector S. Villasano on 4/28/20.
//  Copyright © 2020 s. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol HSVPokemonTableViewCellDelegate <NSObject>


- (void)saveToFavorites:(NSNumber *)indexNumber;

@end

NS_ASSUME_NONNULL_END
