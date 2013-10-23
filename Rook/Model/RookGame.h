//
//  RookGame.h
//  Matchismo
//
//  Created by Steve Liddle on 10/19/13.
//  Copyright (c) 2013 Brigham Young University. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "RookCard.h"

#define MAX_PLAYERS     6
#define MIN_PLAYERS     2
#define NO_HIGH_BIDDER  -1

@interface RookGame : NSObject

@property (nonatomic, setter = setHighBidder:) NSInteger highBidder;

// Designated initializer
- (id)initWithNumberOfPlayers:(NSUInteger)numberOfPlayers;

- (RookCard *)cardForPlayer:(NSUInteger)playerIndex atIndex:(NSUInteger)cardIndex;
- (void)flipCardForPlayer:(NSUInteger)playerIndex atIndex:(NSUInteger)cardIndex;
- (RookCard *)nestCardAtIndex:(NSUInteger)cardIndex;
- (NSUInteger)numberOfCardsInNest;
- (NSUInteger)numberOfCardsPerPlayer;
- (void)swapCard:(NSUInteger)cardIndex withNestCard:(NSUInteger)nestIndex;

@end