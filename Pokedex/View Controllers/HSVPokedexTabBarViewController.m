//
//  HSVPokedexTabBarViewController.m
//  Pokedex
//
//  Created by Hector S. Villasano on 4/28/20.
//  Copyright © 2020 s. All rights reserved.
//

#import "HSVPokedexTabBarViewController.h"
#import "HSVPokemonController.h"
#import "HSVPokemonControllerProtocol.h"

@interface HSVPokedexTabBarViewController ()

@property (nonatomic) HSVPokemonController *pokemonController;

@end

@implementation HSVPokedexTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _pokemonController = [HSVPokemonController new];

    for (UIViewController *vc in [self childViewControllers]) {
        if ([vc conformsToProtocol:@protocol(HSVPokemonControllerProtocol)]) {
            UIViewController<HSVPokemonControllerProtocol> *pokemonControllerProtocolVC = (UIViewController<HSVPokemonControllerProtocol> *)vc;
            pokemonControllerProtocolVC.pokemonController = _pokemonController;

        }
    }
}

@end
