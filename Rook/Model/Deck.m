//
//  Deck.m
//  Matchismo
//
//  Created by Steve Liddle on 9/4/13.
//  Copyright (c) 2013 Brigham Young University. All rights reserved.
//
#import "Deck.h"
#import "RookCard.h"

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

- (void)addCard:(Card *)card {
    [self.cards addObject:card];
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

- (NSMutableArray *)drawRandomCards:(NSUInteger)cardCount {
    // This method is helpful for dealing cards in a Rook game
    // If cardCount is positive, do this:
    //    1. Make a mutable array
    //    2. Draw a random card and add it to the array
    //    3. Repeat step 2 as many times as cardCount
    //    4. Sort the array using RookCard's "compareCard:" selector
    //    5. Return a mutable copy of of the sorted array
    // Else return nil
    return nil;
}

- (BOOL)isEmpty {
    return self.cards.count <= 0;
}

- (NSUInteger)size {
    return self.cards.count;
}

@end