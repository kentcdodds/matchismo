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
    if (cardCount > 0) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (int i = 0; i < cardCount; i++) {
            [array addObject:[self drawRandomCard]];
        }
        SEL selector = @selector(compareCard:);
        NSArray *sortedArray = [array sortedArrayUsingSelector:selector];
        return [sortedArray mutableCopy];
    } else {
        return nil;
    }
}

- (BOOL)isEmpty {
    return self.cards.count <= 0;
}

- (NSUInteger)size {
    return self.cards.count;
}

@end