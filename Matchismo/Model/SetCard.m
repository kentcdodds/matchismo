//
//  SetCard.m
//  Matchismo
//
//  Created by Kent Dodds on 10/2/13.
//  Copyright (c) 2013 Kent C. Dodds. All rights reserved.
//

#import "SetCard.h"

#define SCORE           4

#define COLOR_INDEX     0
#define SHAPE_INDEX     1
#define COUNT_INDEX     2
#define SHADE_INDEX     3



@implementation SetCard

- (BOOL)isFaceUp
{
    return true; // Set Cards are always face up.
}

- (int)match:(NSArray *)otherCards
{
    NSMutableArray *colorStrings = [NSMutableArray array];
    NSMutableArray *shapeStrings = [NSMutableArray array];
    NSMutableArray *countStrings = [NSMutableArray array];
    NSMutableArray *shadeStrings = [NSMutableArray array];
    
    [colorStrings addObject:[self getAttribute:COLOR_INDEX]];
    [shapeStrings addObject:[self getAttribute:SHAPE_INDEX]];
    [countStrings addObject:[self getAttribute:COUNT_INDEX]];
    [countStrings addObject:[self getAttribute:SHADE_INDEX]];
    
    for (SetCard *otherCard in otherCards) {
        [colorStrings addObject:[otherCard getAttribute:COLOR_INDEX]];
        [shapeStrings addObject:[otherCard getAttribute:SHAPE_INDEX]];
        [countStrings addObject:[otherCard getAttribute:COUNT_INDEX]];
        [shadeStrings addObject:[otherCard getAttribute:SHADE_INDEX]];
    }
    
    BOOL *passColor = [self matchOrNoMatch:colorStrings];
    BOOL *passShape = [self matchOrNoMatch:shapeStrings];
    BOOL *passCount = [self matchOrNoMatch:countStrings];
    BOOL *passShade = [self matchOrNoMatch:shadeStrings];
    
    return (passColor && passShape && passCount && passShade) ? SCORE : -SCORE;
}

- (BOOL)matchOrNoMatch:(NSArray *)strings
{
    BOOL *matching = strings[0] == strings[1];
    for (int i = 2; i < [strings count]; i++) {
        BOOL *match = strings[i] == strings[i - 1];
        if (match != matching) {
            // We match when we're not supposed to be or vice versa
            return false;
        }
    }
    // matchOrNoMatch if we make it this far
    return true;
}

- (NSString *)getAttribute:(int)index
{
    return [self.contents substringWithRange:NSMakeRange(index, 1)];
}

- (void)setAttribute:(int)index :(NSString *)value
{
    [self.contents stringByReplacingOccurrencesOfString:self.contents withString:value options:0 range: (NSRange) {index, index}];
}

-(void)setAttributes:(NSString *)color :(NSString *)shape :(NSString *)count :(NSString *)shade {
    [self setAttribute:COLOR_INDEX :color];
    [self setAttribute:SHAPE_INDEX :shape];
    [self setAttribute:COUNT_INDEX :count];
    [self setAttribute:SHADE_INDEX :shade];
}

//number (one, two, or three); symbol (diamond, squiggle, oval); shading (solid, striped, or open); and color (red, green, or purple)
+ (NSArray *)validColors
{
    return [NSArray arrayWithObjects:@"R",@"G",@"P", nil];
}

+ (NSArray *)validShapes
{
    return [NSArray arrayWithObjects:@"D",@"S",@"O", nil];
}

+ (NSArray *)validCounts
{
    return [NSArray arrayWithObjects:@"1",@"2",@"3", nil];
}

+ (NSArray *)validShades
{
    return [NSArray arrayWithObjects:@"S",@"T",@"O", nil];
}
@end
