//
//  HSVSerebiiViewController.h
//  Pokedex
//
//  Created by Hector S. Villasano on 5/11/20.
//  Copyright © 2020 s. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HSVSerebiiViewController : UIViewController<WKNavigationDelegate>

@property (nonatomic, copy) NSString *pokemonName;
@property (nonatomic, copy) NSString *urlString;

@end

NS_ASSUME_NONNULL_END
