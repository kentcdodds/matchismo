//
//  PlayingCard.h
//  Matchismo
//
//  Created by Steve Liddle on 9/4/13.
//  Copyright (c) 2013 Brigham Young University. All rights reserved.
//
#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validRanks;
+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end