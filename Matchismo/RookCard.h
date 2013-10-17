//
//  RookCard.h
//  Matchismo
//
//  Created by Kent Dodds on 10/16/13.
//  Copyright (c) 2013 Kent C. Dodds. All rights reserved.
//

#import "PlayingCard.h"

#define ROOK_RANK           0
#define ROOK_SUIT           @"K"
#define ROOK_SUIT_NAME      @"Rook"

@interface RookCard : PlayingCard

+ (NSArray *)validSuitNames;

@end