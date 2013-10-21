//
//  RookCard.m
//  SuperCard
//
//  Created by Steve Liddle on 9/20/13.
//  Copyright (c) 2013 Stanford University. All rights reserved.
//
#import "RookCard.h"

@implementation RookCard

#pragma mark - Getters and setters

@synthesize suit = _suit; // because we provide setter AND getter

- (NSString *)suit {
    return _suit ? _suit : @"?";
}

- (void)setSuit:(NSString *)suit {
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

#pragma mark - Class methods

+ (NSUInteger)maxRank {
    return [self validRanks].count - 1;
}

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

#pragma mark - Helpers

- (NSComparisonResult)compareCard:(RookCard *)card {
    // First compare the suits, because we want suits to be grouped together
    // This will sort in this order: Black, Green, Rook, Red, Yellow
    NSComparisonResult result = [self.suit compare:card.suit];

    if (result == NSOrderedSame) {
        // If suits are the same, next compare ranks
        result = [@(self.rank) compare:@(card.rank)];
    }

    return result;
}

- (BOOL)isRook {
    return [self.suit isEqualToString:ROOK_SUIT] && self.rank == ROOK_RANK;
}

@end