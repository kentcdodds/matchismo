//
//  RookCard.h
//  SuperCard
//
//  Created by Steve Liddle on 9/20/13.
//  Copyright (c) 2013 Stanford University. All rights reserved.
//
#import "Card.h"

#define ROOK_RANK           0
#define ROOK_SUIT           @"K"
#define ROOK_SUIT_NAME      @"Rook"

@interface RookCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;
@property (nonatomic, getter = isSelected) BOOL selected;

- (NSComparisonResult)compareCard:(RookCard *)card;

+ (NSUInteger)maxRank;
+ (NSArray *)validRanks;
+ (NSArray *)validSuitNames;
+ (NSArray *)validSuits;

@end