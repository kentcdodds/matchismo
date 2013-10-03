//
//  SetCard.h
//  Matchismo
//
//  Created by Kent Dodds on 10/2/13.
//  Copyright (c) 2013 Kent C. Dodds. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

-(void)setAttributes:(NSString *)color :(NSString *)shape :(NSString *)count :(NSString *)shade;
+ (NSArray *)validColors;
+ (NSArray *)validShapes;
+ (NSArray *)validCounts;
+ (NSArray *)validShades;

@end
