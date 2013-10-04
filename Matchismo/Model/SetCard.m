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

- (bool)isFaceUp
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
    [shadeStrings addObject:[self getAttribute:SHADE_INDEX]];
    
    for (SetCard *otherCard in otherCards) {
        [colorStrings addObject:[otherCard getAttribute:COLOR_INDEX]];
        [shapeStrings addObject:[otherCard getAttribute:SHAPE_INDEX]];
        [countStrings addObject:[otherCard getAttribute:COUNT_INDEX]];
        [shadeStrings addObject:[otherCard getAttribute:SHADE_INDEX]];
    }
    
    bool *passColor = [self matchOrNoMatch:colorStrings];
    bool *passShape = [self matchOrNoMatch:shapeStrings];
    bool *passCount = [self matchOrNoMatch:countStrings];
    bool *passShade = [self matchOrNoMatch:shadeStrings];
    
    return (passColor && passShape && passCount && passShade) ? SCORE : -SCORE;
}

- (bool)matchOrNoMatch:(NSArray *)strings
{
    if ([strings count] < 3) {
        return false;
    }
    bool *matching = [strings[0] isEqualToString:strings[1]];
    for (int i = 2; i < [strings count]; i++) {
        for (int j = 0; j < [strings count]; j++) {
            if (i == j) {
                continue;
            }
            bool *match = [strings[i] isEqualToString:strings[j]];
            if (match != matching) {
                // We match when we're not supposed to be or vice versa
                return false;
            }
        }
    }
    // matchOrNoMatch if we make it this far
    return true;
}

- (NSString *)getAttribute:(int)index
{
    return [self.contents substringWithRange:NSMakeRange(index, 1)];
}

- (void)setAttributes:(NSString *)color :(NSString *)shape :(NSString *)count :(NSString *)shade {
    self.contents = [NSString stringWithFormat:@"%@%@%@%@", color, shape, count, shade];
}

//number (one, two, or three); symbol (circle, triangle, square); shading (solid, striped, or open); and color (red, green, or purple)
+ (NSArray *)validColors
{
    return [NSArray arrayWithObjects:@"R",@"G",@"P", nil];
}

+ (NSArray *)validShapes
{
    return [NSArray arrayWithObjects:@"●",@"▴",@"■", nil];
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
