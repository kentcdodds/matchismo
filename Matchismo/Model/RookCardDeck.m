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

- (void)setup {
    for (NSString *suit in [RookCard validSuits]) {
        if (![suit isEqualToString:ROOK_SUIT]) {
            for (NSUInteger rank = 1; rank <= [RookCard maxRank]; rank++) {
                RookCard *card = [[RookCard alloc] init];

                card.rank = rank;
                card.suit = suit;

                [self addCard:card atTop:NO];
            }
        }
    }

    RookCard *rook = [[RookCard alloc] init];

    rook.rank = ROOK_RANK;
    rook.suit = ROOK_SUIT;
    
    [self addCard:rook atTop:NO];
}

@end