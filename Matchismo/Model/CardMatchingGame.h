//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Steve Liddle on 9/16/13.
//  Copyright (c) 2013 Brigham Young University. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

- (Card *)cardAtIndex:(NSUInteger)index;
- (void)flipCardAtIndex:(NSUInteger)index;
- (id)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck;

@property (nonatomic, readonly) NSInteger score;

@end