//
//  RookCard.m
//  Matchismo
//
//  Created by Kent Dodds on 10/16/13.
//  Copyright (c) 2013 Kent C. Dodds. All rights reserved.
//
#import "RookCard.h"

#define RANK_MATCH_SCORE    4
#define SUIT_MATCH_SCORE    1

@implementation RookCard

#pragma mark - Helpers

- (BOOL)isRook {
    return [self.suit isEqualToString:ROOK_SUIT] &&
    self.rank == ROOK_RANK;
}

#pragma mark - Overridden methods

- (NSInteger)match:(NSArray *)otherCards {
    NSInteger score = 0;
    
    if ([otherCards count] == 1) {
        RookCard *otherCard = [otherCards lastObject];
        
        if ([otherCard.suit isEqualToString:self.suit]) {
            score = SUIT_MATCH_SCORE;
        } else if (otherCard.rank == self.rank) {
            score = RANK_MATCH_SCORE;
        }
    }
    
    return score;
}

#pragma mark - Class methods

+ (NSArray *)validRanks {
    static NSArray *ranks;
    
    if (!ranks) {
        // Note that "R" is the rook's "rank"
        ranks = @[@"R",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14"];
    }
    
    return ranks;
}

+ (NSArray *)validSuits {
    static NSArray *suits;
    
    if (!suits) {
        suits = @[@"K",@"R",@"G",@"B",@"Y"];
    }
    
    return suits;
}

+ (NSArray *)validSuitNames {
    static NSArray *suits;
    
    if (!suits) {
        suits = @[@"Rook", @"Red", @"Green", @"Black", @"Yellow"];
    }
    
    return suits;
}

@end