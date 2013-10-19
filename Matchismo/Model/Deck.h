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

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (Card *)drawLastCard;
- (Card *)drawRandomCard;
- (BOOL)isEmpty;

@end