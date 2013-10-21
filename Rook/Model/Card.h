//
//  Card.h
//  Matchismo
//
//  Created by Steve Liddle on 9/3/13.
//  Copyright (c) 2013 Brigham Young University. All rights reserved.
//
#import <Foundation/NSObject.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;
@property (nonatomic, getter = isFaceUp) BOOL faceUp;

@end