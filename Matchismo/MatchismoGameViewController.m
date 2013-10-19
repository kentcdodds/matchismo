//
//  MatchismoGameViewController.m
//  Matchismo
//
//  Created by Steve Liddle on 10/14/13.
//  Copyright (c) 2013 Brigham Young University. All rights reserved.
//
#import "MatchismoGameViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"
#import "PlayingCardCollectionViewCell.h"

@implementation MatchismoGameViewController

- (Deck *)createDeck {
    return [[PlayingCardDeck alloc] init];
}

- (void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card {
    if ([cell isKindOfClass:[PlayingCardCollectionViewCell class]]) {
        PlayingCardView *playingCardView = ((PlayingCardCollectionViewCell *)cell).playingCardView;
        
        if ([card isKindOfClass:[PlayingCard class]]) {
            PlayingCard *playingCard = (PlayingCard *)card;

            playingCardView.rank = playingCard.rank;
            playingCardView.rankAsString = [PlayingCard validRanks][playingCard.rank];
            playingCardView.suit = playingCard.suit;
            playingCardView.faceUp = playingCard.isFaceUp;
            playingCardView.alpha = playingCard.isUnplayable ? CARD_DISABLED_ALPHA : CARD_ENABLED_ALPHA;
        }
    }
}

- (NSString *)cardReuseIdentifier {
    return @"PlayingCard";
}

- (NSUInteger)startingCardCount {
    return 16;
}

@end