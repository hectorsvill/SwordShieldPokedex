//
//  HSVNetworking.m
//  Pokedex
//
//  Created by s on 4/22/20.
//  Copyright © 2020 s. All rights reserved.
//

#import "HSVNetworking.h"
#import "HSVPokemon.h"
#import "NSError+HSVErrorWithString.h"
#import "HSVNetworking+HSVPokemonIndexString.h"

@interface HSVNetworking ()

@property (nonatomic, readonly, copy) NSURL *baseURL;
@property (nonatomic, readonly, copy) NSString *baseImageString;
@property (nonatomic, readonly, copy) NSString *baseShinyImageString;

@end

@implementation HSVNetworking

- (instancetype)init
{
    if (self = [super init]){
        _baseURL = [NSURL URLWithString:@"https://pokeapi.co/api/v2/pokemon/"];
        _baseImageString = @"https://www.serebii.net/swordshield/pokemon/";// 001.png
        _baseShinyImageString = @"https://www.serebii.net/Shiny/SWSH/";
    }

    return self;
}

- (void)fetchPokemonList:(void (^)(NSArray<HSVPokemon *> *, NSError *))completion
{
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:_baseURL resolvingAgainstBaseURL:true];
    NSURLQueryItem *limitQuery = [NSURLQueryItem queryItemWithName:@"limit" value:@"1000"];
    urlComponents.queryItems = @[limitQuery];
    NSURL *url = urlComponents.URL;

    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            return completion(nil, error);
        }

        if (!data) {
            NSError *dataError =  [[NSError new] HSVErrorWithString:@"Data Error"];
            return completion(nil, dataError);
        }

        NSError *jsonError;
        NSDictionary *pokemonListDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];

        if (jsonError) {
            return completion(nil, jsonError);
        }

        if (!pokemonListDictionary || ![pokemonListDictionary isKindOfClass:[NSDictionary class]]) {
            NSError *pokemonListDictionaryError = [[NSError new] HSVErrorWithString:@"pokemonListDictionary Error"];
            return completion(nil, pokemonListDictionaryError);
        }

        NSDictionary *results = pokemonListDictionary[@"results"];
        NSMutableArray<HSVPokemon*> *pokemonList = [NSMutableArray new];

        for (NSDictionary *pokemon in results) {
            NSString *name = pokemon[@"name"];
            NSString *detailURLString = pokemon[@"url"];
            NSURL *detailURL = [NSURL URLWithString:detailURLString];

            HSVPokemon *pokemon = [[HSVPokemon new] initWithName:name detailURL:detailURL];
            [pokemonList addObject:pokemon];
        }

        return completion(pokemonList, nil);
    }] resume];

}

- (void)fetchImageDataWithIndex:(int)index completion:(void (^)(NSData *, NSError *))completion
{
    NSString *indexString = [self HSVCreatePokemonIndexString:index];
    NSString *urlString = [NSString stringWithFormat:@"%@%@.png", _baseImageString, indexString];
    NSURL *url = [NSURL URLWithString:urlString];
//    NSError *imageDataerror = [[NSError new] HSVErrorWithString:@"fetchImageDataWithIndex, Image Data Error"];
    NSData *data = [NSData dataWithContentsOfURL:url];

//    if (imageDataerror) {
//        return completion(nil, imageDataerror);
//    }

    return completion(data, nil);
}

@end
