//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Kent Dodds on 9/21/13.
//  Copyright (c) 2013 Kent C. Dodds. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Deck.h"

@interface CardMatchingGame : NSObject

@property (readonly, nonatomic) int score;
@property (readonly, nonatomic) NSString *recentActionResult;
@property (readonly, nonatomic) int cardsToMatch;

- (id)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;

- (Card *)cardAtIndex:(NSUInteger)index;
- (void)flipCardAtIndex:(NSUInteger)index;

@end
