//
//  RookCardView.m
//  Matchismo
//
//  Created by Kent Dodds on 10/16/13.
//  Copyright (c) 2013 Kent C. Dodds. All rights reserved.
//

#import "RookCardView.h"
#import "RookCard.h"

#define CORNER_FONT_SCALE_FACTOR        PIP_FONT_SCALE_FACTOR
#define CORNER_ROOK_SCALE_FACTOR        0.18
#define CORNER_SUIT_FONT_SCALE_FACTOR   CORNER_FONT_SCALE_FACTOR * 0.333
#define FONT_NAME                       @"Palatino-Bold"
#define FONT_SCALE_FACTOR               0.55
#define RGB_COLOR(r,g,b)                [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define SQUARE_MARGIN                   (self.bounds.size.width * 0.189)
#define SQUARE_STROKE_WIDTH             (self.bounds.size.width * 0.005)
#define UNDERLINE_OFFSET                (self.bounds.size.width * 0.0333)
#define UNDERLINE_INSET                 (self.bounds.size.width * 0.0111)
#define UNDERLINE_STROKE_WIDTH          (self.bounds.size.width * 0.0111)

@interface RookCardView()
@property (strong, nonatomic) NSDictionary *suitColors;
@end

@implementation RookCardView

#pragma mark - Properties

- (NSString *)cardbackImagename {
    return @"RookBack.png";
}

- (NSDictionary *)suitColors {
    if (!_suitColors) {
        _suitColors = @{ @"ROOK"   : RGB_COLOR( 34, 193, 196),
                         @"RED"    : RGB_COLOR(237,  37,  50),
                         @"GREEN"  : RGB_COLOR( 36, 193,  80),
                         @"YELLOW" : RGB_COLOR(242, 199,  58),
                         @"BLACK"  : [UIColor blackColor]
                         };
    }
    
    return _suitColors;
}

#pragma mark - Drawing

- (void)drawCorners {
    UIFont *cornerFont = [UIFont fontWithName:FONT_NAME size:self.bounds.size.width * CORNER_FONT_SCALE_FACTOR];
    UIFont *cornerSuitFont = [UIFont fontWithName:FONT_NAME size:self.bounds.size.width * CORNER_SUIT_FONT_SCALE_FACTOR];
    UIImage *rookImage;
    CGRect rookImageRect;
    
    NSAttributedString *cornerText = [[NSAttributedString alloc]
                                      initWithString:self.rankAsString
                                      attributes:@{ NSFontAttributeName : cornerFont,
                                                    NSForegroundColorAttributeName : [self suitColor]}];
    NSAttributedString *suitText = [[NSAttributedString alloc]
                                    initWithString:[self.suitName uppercaseString]
                                    attributes:@{ NSFontAttributeName : cornerSuitFont,
                                                  NSForegroundColorAttributeName : [self suitColor]}];
    CGRect textBounds;
    textBounds.origin = CGPointMake(CORNER_X_OFFSET, CORNER_Y_OFFSET);
    textBounds.origin.y -= (cornerFont.lineHeight - cornerFont.capHeight + cornerFont.descender);
    textBounds.size = [cornerText size];
    
    if (self.rank == ROOK_RANK) {
        rookImage = [self newImageFromMaskImage:[UIImage imageNamed:@"squareRook.png"]
                                        inColor:self.suitColors[@"ROOK"]];
        rookImageRect = CGRectMake(CORNER_X_OFFSET, CORNER_Y_OFFSET,
                                   self.bounds.size.width * CORNER_ROOK_SCALE_FACTOR,
                                   self.bounds.size.width * CORNER_ROOK_SCALE_FACTOR);
        [rookImage drawInRect:rookImageRect];
    } else {
        [cornerText drawInRect:textBounds];
    }
    
    CGRect suitBounds;
    suitBounds.origin = CGPointMake(CORNER_X_OFFSET + textBounds.size.width, CORNER_Y_OFFSET);
    suitBounds.size = [suitText size];
    [suitText drawInRect:suitBounds];
    
    [self pushContextAndRotateUpsideDown];
    
    if (self.rank == ROOK_RANK) {
        [rookImage drawInRect:rookImageRect];
    } else {
        [cornerText drawInRect:textBounds];
    }
    
    [suitText drawInRect:suitBounds];
    
    [self popContext];
}

- (void)drawFace {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    UIFont *font = [UIFont fontWithName:FONT_NAME size:self.bounds.size.width * FONT_SCALE_FACTOR];
    
    NSAttributedString *text = [[NSAttributedString alloc]
                                initWithString:self.rankAsString
                                attributes:@{ NSParagraphStyleAttributeName : paragraphStyle,
                                              NSFontAttributeName : font,
                                              NSForegroundColorAttributeName : [self suitColor]}];
    CGRect textBounds;
    
    textBounds.size = [text size];
    textBounds.origin = CGPointMake((self.bounds.size.width - textBounds.size.width) / 2.0,
                                    (self.bounds.size.height - textBounds.size.height) / 2.0);
    [text drawInRect:textBounds];
    
    if (self.rank == 6 || self.rank == 9) {
        // Need to underline the bottom of the main number
        UIBezierPath *underline = [[UIBezierPath alloc] init];
        CGFloat yOffset = textBounds.origin.y + textBounds.size.height + font.descender + UNDERLINE_OFFSET;
        
        [underline moveToPoint:CGPointMake(textBounds.origin.x + UNDERLINE_INSET, yOffset)];
        [underline addLineToPoint:CGPointMake(textBounds.origin.x + textBounds.size.width - 2 * UNDERLINE_INSET, yOffset)];
        underline.lineWidth = UNDERLINE_STROKE_WIDTH;
        [underline stroke];
    }
    
    UIBezierPath *rect = [[UIBezierPath alloc] init];
    
    CGFloat width = self.bounds.size.width - (2.0 * SQUARE_MARGIN);
    CGFloat yOffset = (self.bounds.size.height - width) / 2.0;
    
    rect.lineWidth = SQUARE_STROKE_WIDTH;
    [rect moveToPoint:CGPointMake(SQUARE_MARGIN, yOffset)];
    [rect addLineToPoint:CGPointMake(SQUARE_MARGIN + width, yOffset)];
    [rect addLineToPoint:CGPointMake(SQUARE_MARGIN + width, yOffset + width)];
    [rect addLineToPoint:CGPointMake(SQUARE_MARGIN, yOffset + width)];
    [rect closePath];
    [rect stroke];
}

- (UIImage *)newImageFromMaskImage:(UIImage *)mask inColor:(UIColor *)color {
    // This little beauty renders a bitmap as a solid color, much like tab icons,
    // only paying attention to the alpha channel of the incoming bitmap.  This is
    // here to draw the aqua-colored rook birds in the corners.  See this StackOverflow
    // post for more details: http://bit.ly/19vz3oT
    // I could have avoided this by using Photoshop to create exactly the bitmap I
    // wanted in the first place, but this lets me set the color programmatically.
    CGImageRef maskImage = mask.CGImage;
    CGFloat width = mask.size.width;
    CGFloat height = mask.size.height;
    CGRect bounds = CGRectMake(0, 0, width, height);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef bitmapContext = CGBitmapContextCreate(NULL, width, height, 8, 0, colorSpace, (CGBitmapInfo)kCGImageAlphaPremultipliedLast);
    CGContextClipToMask(bitmapContext, bounds, maskImage);
    CGContextSetFillColorWithColor(bitmapContext, color.CGColor);
    CGContextFillRect(bitmapContext, bounds);
    
    CGImageRef mainViewContentBitmapContext = CGBitmapContextCreateImage(bitmapContext);
    CGContextRelease(bitmapContext);
    
    UIImage *result = [UIImage imageWithCGImage:mainViewContentBitmapContext];
    
    return result;
}

#pragma mark - Helpers

- (NSString *)suitColor {
    return self.suitColors[[self.suitName uppercaseString]];
}

@end