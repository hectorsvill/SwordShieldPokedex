//
//  NSError+HSVErrorWithString.m
//  Pokedex
//
//  Created by s on 4/22/20.
//  Copyright © 2020 s. All rights reserved.
//

#import "NSError+HSVErrorWithString.h"

@implementation NSError (HSVErrorWithString)

- (NSError *)HSVErrorWithString:(NSString *)string
{
    return [NSError errorWithDomain:@"com.hectorstevenvillasano.Pokedex" code:-1 userInfo:@{@"Error": string}];
}

@end
