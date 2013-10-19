//
//  PlayingCardDeck.m
//  Matchismo
//
//  Created by Steve Liddle on 9/4/13.
//  Copyright (c) 2013 Brigham Young University. All rights reserved.
//
#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@implementation PlayingCardDeck

- (id)init {
    self = [super init];
    
    if (self) {
        [self setup];
    }

    return self;
}

// By factoring out the initialization code to a setup method,
// we can override it in subclasses.
- (void)setup {
    for (NSString *suit in [PlayingCard validSuits]) {
        for (NSUInteger rank = 1; rank <= [PlayingCard maxRank]; rank++) {
            PlayingCard *card = [[PlayingCard alloc] init];
            
            card.rank = rank;
            card.suit = suit;
            
            [self addCard:card atTop:YES];
        }
    }
}

@end