//
//  RookCard.h
//  SuperCard
//
//  Created by Steve Liddle on 9/20/13.
//  Copyright (c) 2013 Stanford University. All rights reserved.
//
#import "PlayingCard.h"

#define ROOK_RANK           0
#define ROOK_SUIT           @"K"
#define ROOK_SUIT_NAME      @"Rook"

@interface RookCard : PlayingCard

+ (NSArray *)validSuitNames;

@end