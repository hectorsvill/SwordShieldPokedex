//
//  NSError+HSVErrorWithString.h
//  Pokedex
//
//  Created by s on 4/22/20.
//  Copyright © 2020 s. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSError (HSVErrorWithString)

- (NSError *)HSVErrorWithString:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
