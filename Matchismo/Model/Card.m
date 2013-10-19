//
//  Card.m
//  Matchismo
//
//  Created by Steve Liddle on 9/3/13.
//  Copyright (c) 2013 Brigham Young University. All rights reserved.
//
#import "Card.h"

@implementation Card

- (NSInteger)match:(NSArray *)otherCards {
    NSInteger score = 0;
    
    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    
    return score;
}

@end