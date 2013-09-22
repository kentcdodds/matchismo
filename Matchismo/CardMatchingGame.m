//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Kent Dodds on 9/21/13.
//  Copyright (c) 2013 Kent C. Dodds. All rights reserved.
//

#import "CardMatchingGame.h"

#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define FLIP_COST 1

@interface CardMatchingGame()

@property (readwrite, nonatomic) int score;
@property (readwrite, nonatomic) NSString *recentActionResult;
@property (readwrite, nonatomic) int cardsToMatch;

@property (strong, nonatomic) NSMutableArray *cards; // of type Card

@end

@implementation CardMatchingGame

@synthesize cardsToMatch = _cardsToMatch;

- (id)initWithCardCount:(NSUInteger)count
              usingDeck:(Deck *)deck
{
    self = [super init];
    if (self) {
        self.cardsToMatch = 2;
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                self.cards[i] = card;
            } else {
                self = nil;
                break;
            }
        }
    }
    return self;
}

- (NSMutableArray *)cards
{
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

- (int)cardsToMatch
{
    if (!_cardsToMatch) {
        _cardsToMatch = 2;
    }
    return _cardsToMatch;
}

- (void)setCardsToMatch:(int)cardsToMatch
{
    //TODO: Support any number here.
    switch (cardsToMatch) {
        case 3:
            _cardsToMatch = 3;
            break;
        default:
            _cardsToMatch = 2;
            break;
    }
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count] ? self.cards[index] : nil);
}

- (void)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    NSString *newResult = @"";
    
    if (card && !card.isUnplayable) {
        if (!card.isFaceUp) {
            NSMutableArray *matchableCards = [[NSMutableArray alloc] init];
            NSMutableArray *matchableContents = [[NSMutableArray alloc] init];
            for (Card *otherCard in self.cards) {
                if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                    [matchableCards addObject:otherCard];
                    [matchableContents addObject:otherCard.contents];
                }
            }
            if ([matchableCards count] < self.cardsToMatch - 1) {
                newResult = [NSString stringWithFormat:@"%@ Flipped\nPenalty:%d", card.contents, FLIP_COST];
            } else {
                NSString *combinedContents = [matchableContents componentsJoinedByString:@" & "];
                int matchScore = [card match:matchableCards];
                if (matchScore) {
                    card.unplayable = YES;
                    for (Card *otherCard in matchableCards) {
                        otherCard.unplayable = YES;
                    }
                    self.score += matchScore * MATCH_BONUS;
                    newResult =
                    [NSString stringWithFormat:@"%@ matched %@\nBonus: %d",
                     card.contents,
                     combinedContents,
                     matchScore * MATCH_BONUS];
                } else {
                    for (Card *otherCard in matchableCards) {
                        otherCard.faceUp = NO;
                    }
                    self.score -= MISMATCH_PENALTY;
                    newResult =
                    [NSString stringWithFormat:@"%@ does not match %@\nPenalty: %d",
                     card.contents,
                     combinedContents,
                     MISMATCH_PENALTY];
                }
            }
            self.score -= FLIP_COST;
        }
        card.faceUp = !card.faceUp;
    }
    self.recentActionResult = newResult;
}
@end
