//
//  RookCardDeck.m
//  SuperCard
//
//  Created by Steve Liddle on 9/20/13.
//  Copyright (c) 2013 Stanford University. All rights reserved.
//
#import "RookCardDeck.h"
#import "RookCard.h"

@implementation RookCardDeck

- (id)init {
    self = [super init];
    
    if (self) {
        [self setup];
    }
    
    return self;
}

- (void)setup {
    for (NSString *suit in [RookCard validSuits]) {
        if (![suit isEqualToString:ROOK_SUIT]) {
            for (NSUInteger rank = 1; rank <= [RookCard maxRank]; rank++) {
                RookCard *card = [[RookCard alloc] init];

                card.rank = rank;
                card.suit = suit;
                card.faceUp = YES;

                [self addCard:card];
            }
        }
    }

    RookCard *rook = [[RookCard alloc] init];

    rook.rank = ROOK_RANK;
    rook.suit = ROOK_SUIT;
    rook.faceUp = YES;
    
    [self addCard:rook];
}

@end