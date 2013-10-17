//
//  PlayingCard.m
//  Matchismo
//
//  Created by Kent Dodds on 9/21/13.
//  Copyright (c) 2013 Kent C. Dodds. All rights reserved.
//

#import "PlayingCard.h"

#define RANK_MATCH_SCORE    4
#define SUIT_MATCH_SCORE    1

@implementation PlayingCard

@synthesize suit = _suit; // because we provide setter AND getter

- (NSString *)suit {
    return _suit ? _suit : @"?";
}

- (void)setSuit:(NSString *)suit {
    // By calling [self class] instead of [PlayingCard class]
    // we allow subclasses to override the validSuits call
    // without having to rewrite this suit setter.
    if ([[[self class] validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (void)setRank:(NSUInteger)rank {
    if (rank <= [[self class] maxRank]) {
        _rank = rank;
    }
}

#pragma mark - Overridden methods

- (NSString *)contents {
    NSArray *rankStrings = [[self class] validRanks];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

- (NSInteger)match:(NSArray *)otherCards {
    NSInteger score = 0;
    
    if ([otherCards count] == 1) {
        id otherCard = [otherCards lastObject];
        
        if ([otherCard isKindOfClass:[PlayingCard class]]) {
            PlayingCard *otherPlayingCard = (PlayingCard *)otherCard;
            
            if ([otherPlayingCard.suit isEqualToString:self.suit]) {
                score = SUIT_MATCH_SCORE;
            } else if (otherPlayingCard.rank == self.rank) {
                score = RANK_MATCH_SCORE;
            }
        }
    }
    
    return score;
}

#pragma mark - Class methods

+ (NSUInteger)maxRank {
    return [self validRanks].count - 1;
}

+ (NSArray *)validRanks {
    static NSArray *ranks;
    
    if (!ranks) {
        ranks = @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
    }
    
    return ranks;
}

+ (NSArray *)validSuits {
    static NSArray *suits;
    
    if (!suits) {
        suits = @[@"♥",@"♦",@"♠",@"♣"];
    }
    
    return suits;
}

@end