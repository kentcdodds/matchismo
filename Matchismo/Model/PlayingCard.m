//
//  PlayingCard.m
//  Matchismo
//
//  Created by Kent Dodds on 9/21/13.
//  Copyright (c) 2013 Kent C. Dodds. All rights reserved.
//

#import "PlayingCard.h"

#define SUIT_POINTS     1
#define RANK_POINTS     4

@implementation PlayingCard

- (NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit; // because we provide setter && getter

- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    for (PlayingCard *otherCard in otherCards) {
        if ([otherCard.suit isEqualToString:self.suit]) {
            score += SUIT_POINTS;
        } else if (otherCard.rank == self.rank) {
            score += RANK_POINTS;
        } else {
            return 0; // If they don't all match one way or another, then too bad.
        }
    }
    /*
    NSLog([NSString stringWithFormat:@"Card Count: %d", [otherCards count]]);
    
    // Multiply score by 0.5 for every card above 1 that matches.
    if ([otherCards count] > 1) {
        NSLog([NSString stringWithFormat: @"Multiplying score: %d", score]);
        score = score * ([otherCards count] + 1) / 2;
        NSLog([NSString stringWithFormat: @"Multiplied score: %d", score]);
    }*/

    return score;
}

+ (NSArray *)validSuits
{
    return @[@"♥", @"♦", @"♠", @"♣"];
}

+ (NSArray *)rankStrings
{
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSUInteger)maxRank
{
    return [self rankStrings].count - 1;
}

@end
