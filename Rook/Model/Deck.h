//
//  Deck.h
//  Matchismo
//
//  Created by Steve Liddle on 9/4/13.
//  Copyright (c) 2013 Brigham Young University. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card;
- (Card *)drawRandomCard;
- (NSMutableArray *)drawRandomCards:(NSUInteger)cardCount;
- (BOOL)isEmpty;
- (NSUInteger)size;

@end