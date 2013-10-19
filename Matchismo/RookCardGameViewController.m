//
//  RookCardGameViewController.m
//  Matchismo
//
//  Created by Steve Liddle on 10/14/13.
//  Copyright (c) 2013 Brigham Young University. All rights reserved.
//
#import "RookCardGameViewController.h"
#import "RookCardDeck.h"
#import "RookCard.h"
#import "RookCardCollectionViewCell.h"

@implementation RookCardGameViewController

- (Deck *)createDeck {
    return [[RookCardDeck alloc] init];
}

- (void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card {
    if ([cell isKindOfClass:[RookCardCollectionViewCell class]]) {
        RookCardView *rookCardView = ((RookCardCollectionViewCell *)cell).rookCardView;
        
        if ([card isKindOfClass:[RookCard class]]) {
            RookCard *rookCard = (RookCard *)card;
            
            rookCardView.rank = rookCard.rank;
            rookCardView.rankAsString = [RookCard validRanks][rookCard.rank];
            rookCardView.suit = rookCard.suit;
            rookCardView.suitName = [RookCard validSuitNames][[[RookCard validSuits] indexOfObject:rookCard.suit]];
            rookCardView.faceUp = rookCard.isFaceUp;
            rookCardView.alpha = rookCard.isUnplayable ? CARD_DISABLED_ALPHA : CARD_ENABLED_ALPHA;
        }
    }
}

- (NSString *)cardReuseIdentifier {
    return @"RookCard";
}

- (NSUInteger)startingCardCount {
    return 20;
}

@end