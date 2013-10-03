//
//  SetDeck.m
//  Matchismo
//
//  Created by Kent Dodds on 10/2/13.
//  Copyright (c) 2013 Kent C. Dodds. All rights reserved.
//

#import "SetDeck.h"
#import "SetCard.h"

@implementation SetDeck

- (void)setup
{
    for (NSString *color in [SetCard validColors]) {
        for (NSString *shape in [SetCard validShapes]) {
            for (NSString *count in [SetCard validCounts]) {
                for (NSString *shade in [SetCard validShades]) {
                    SetCard *card = [[SetCard alloc] init];
                    [card setAttributes:color :shape :count :shade];
                    [self addCard:card atTop:YES];
                }
            }
        }
    }
}

@end
