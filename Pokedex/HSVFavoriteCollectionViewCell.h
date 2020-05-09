//
//  HSVFavoriteCollectionViewCell.h
//  Pokedex
//
//  Created by Hector S. Villasano on 5/8/20.
//  Copyright © 2020 s. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HSVFavoriteCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *pokemonImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

NS_ASSUME_NONNULL_END
