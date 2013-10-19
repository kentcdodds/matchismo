//
//  Deck.m
//  Matchismo
//
//  Created by Steve Liddle on 9/4/13.
//  Copyright (c) 2013 Brigham Young University. All rights reserved.
//
#import "Deck.h"

@interface Deck()
@property (strong, nonatomic) NSMutableArray *cards; // of Card
@end

@implementation Deck

#pragma mark - Getters and setters

- (NSMutableArray *)cards {
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    
    return _cards;
}

#pragma mark - Helper methods

- (void)addCard:(Card *)card atTop:(BOOL)atTop {
    if (atTop) {
        [self.cards insertObject:card atIndex:0];
    } else {
        [self.cards addObject:card];
    }
}

- (Card *)drawLastCard {
    Card *randomCard;
    
    if (self.cards.count > 0) {
        randomCard = self.cards[self.cards.count - 1];
        [self.cards removeObjectAtIndex:self.cards.count - 1];
    }
    
    return randomCard;
}

- (Card *)drawRandomCard {
    Card *randomCard;

    if (self.cards.count > 0) {
        unsigned index = arc4random() % self.cards.count;
        randomCard = self.cards[index];
        [self.cards removeObjectAtIndex:index];
    }
    
    return randomCard;
}

- (BOOL)isEmpty {
    return self.cards.count <= 0;
}

@end