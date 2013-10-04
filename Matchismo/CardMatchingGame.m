//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Kent Dodds on 9/21/13.
//  Copyright (c) 2013 Kent C. Dodds. All rights reserved.
//

#import "CardMatchingGame.h"
#import "Card.h"

#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define ACTIVATE_COST 1

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
    if (cardsToMatch < 2) {
        cardsToMatch = 2;
    } else if (cardsToMatch > [self.cards count]) {
        cardsToMatch = [self.cards count];
    }
    _cardsToMatch = cardsToMatch;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count] ? self.cards[index] : nil);
}

- (void)activateCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    NSString *newResult = @"";
    if (card && !card.isUnplayable) {
        if (!card.isActive) {
            NSMutableArray *matchableCards = [[NSMutableArray alloc] init];
            NSMutableArray *matchableContents = [[NSMutableArray alloc] init];
            for (Card *otherCard in self.cards) {
                if (otherCard.isActive && !otherCard.isUnplayable) {
                    [matchableCards addObject:otherCard];
                    [matchableContents addObject:[otherCard getDisplayString]];
                }
            }
            NSString *combinedContents = [matchableContents componentsJoinedByString:@" & "];
            int matchScore = [card match:matchableCards];
            if ([matchableCards count] < self.cardsToMatch - 1) {;
                newResult = [NSString stringWithFormat:@"%@ Tap\nPenalty:%d", [card getDisplayString], ACTIVATE_COST];
                self.score -= ACTIVATE_COST;
            } else if (matchScore > 0) {
                card.unplayable = YES;
                for (Card *otherCard in matchableCards) {
                    otherCard.unplayable = YES;
                }
                card.active = YES; // Forcing it to inactive.
                self.score += matchScore * MATCH_BONUS;
                newResult =
                [NSString stringWithFormat:@"%@ matched %@\nBonus: %d",
                 [card getDisplayString],
                 combinedContents,
                 matchScore * MATCH_BONUS];
            } else {
                for (Card *otherCard in matchableCards) {
                    otherCard.active = NO;
                }
                card.active = YES; // Forcing it to inactive.
                self.score -= MISMATCH_PENALTY;
                newResult =
                [NSString stringWithFormat:@"%@ does not match %@\nPenalty: %d",
                 [card getDisplayString],
                 combinedContents,
                 MISMATCH_PENALTY];
            }
        }
        card.active = !card.isActive;
    }
    self.recentActionResult = newResult;
}
@end
