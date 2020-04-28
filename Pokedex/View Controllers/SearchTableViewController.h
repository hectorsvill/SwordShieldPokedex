//
//  SearchTableViewController.h
//  Pokedex
//
//  Created by s on 4/22/20.
//  Copyright © 2020 s. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HSVPokemonTableViewCellDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface SearchTableViewController : UITableViewController<UISearchBarDelegate, HSVPokemonTableViewCellDelegate>
@end

NS_ASSUME_NONNULL_END
