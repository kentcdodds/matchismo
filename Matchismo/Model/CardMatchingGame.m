//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Steve Liddle on 9/16/13.
//  Copyright (c) 2013 Brigham Young University. All rights reserved.
//
#import "CardMatchingGame.h"

#define FLIP_COST           1
#define MATCH_BONUS         4
#define MISMATCH_PENALTY    2

@interface CardMatchingGame()
@property (strong, nonatomic) NSMutableArray *cards;
@property (nonatomic) NSInteger score;
@end

@implementation CardMatchingGame

- (id)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck {
    self = [super init];
    
    if (self) {
        for (NSUInteger i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            
            if (card) {
                self.cards[i] = card;
            } else {
                self = nil;
            }
        }
    }
    
    return self;
}

- (NSMutableArray *)cards {
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    
    return _cards;
}

- (Card *)cardAtIndex:(NSUInteger)index {
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (void)flipCardAtIndex:(NSUInteger)index {
    Card *card = [self cardAtIndex:index];
    
    if (!card.isUnplayable) {
        if (!card.isFaceUp) {
            for (Card *otherCard in self.cards) {
                if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                    NSInteger matchScore = [card match:@[otherCard]];
                    
                    // match tells how good a match it is, or 0 if mismatch
                    if (matchScore) {
                        otherCard.unplayable = YES;
                        card.unplayable = YES;
                        self.score += matchScore * MATCH_BONUS;
                    } else {
                        self.score -= MISMATCH_PENALTY;
                    }
                    
                    // We've found another face-up playable card, so stop looking
                    break;
                }
            }
            
            // Always charge a cost to flip face-up
            self.score -= FLIP_COST;
        }
        
        card.faceUp = !card.isFaceUp;
    }
}

@end