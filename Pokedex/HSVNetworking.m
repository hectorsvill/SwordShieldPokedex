//
//  HSVNetworking.m
//  Pokedex
//
//  Created by s on 4/22/20.
//  Copyright © 2020 s. All rights reserved.
//

#import "HSVNetworking.h"
#import "HSVPokemon.h"

@interface HSVNetworking ()

@property (nonatomic, readonly, copy) NSURL *baseURL;

@end

@implementation HSVNetworking

- (instancetype)init
{
    if (self = [super init]){
        _baseURL = [NSURL URLWithString:@"https://pokeapi.co/api/v2/pokemon/"];
    }

    return self;
}

- (void)fetchPokemonList:(void (^)(NSArray<HSVPokemon *> *, NSError *))completion
{
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:_baseURL resolvingAgainstBaseURL:true];
    NSURLQueryItem *limitQuery = [NSURLQueryItem queryItemWithName:@"limit" value:@"100"];

    urlComponents.queryItems = @[limitQuery];
    NSURL *url = urlComponents.URL;

    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            return completion(nil, error);
        }

        if (!data) {
            NSError *dataError = [NSError errorWithDomain:@"com.hectorstevenvillasano.Pokedex" code:-1 userInfo:@{@"Error": @"Data Error"}];
            return completion(nil, dataError);
        }

        NSError *jsonError;
        NSDictionary *pokemonListDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];

        if (jsonError) {
            return completion(nil, jsonError);
        }

        if (!pokemonListDictionary || ![pokemonListDictionary isKindOfClass:[NSDictionary class]]) {
            NSError *pokemonListDictionaryError = [NSError errorWithDomain:@"com.hectorstevenvillasano.Pokedex" code:-1 userInfo:@{@"Error": @"pokemonListDictionary Error"}];
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



@end
