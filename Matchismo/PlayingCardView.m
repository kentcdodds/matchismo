//
//  PlayingCardView.m
//  Matchismo
//
//  Created by Kent Dodds on 10/16/13.
//  Copyright (c) 2013 Kent C. Dodds. All rights reserved.
//

#import "PlayingCardView.h"

@interface PlayingCardView()
@property (nonatomic) CGFloat faceCardScaleFactor;
@property (strong, nonatomic) NSString *cardbackImagename;
@end

#pragma mark - Class implementation

@implementation PlayingCardView

#pragma mark - Initialization

- (void)setup {
    // This is the standard UIView initialization pattern.
    //
    // 1. Override initWithFrame:
    // 2. Call [self setup]
    // 3. Override awakeFromNib
    // 4. Also call [self setup]
    //
    // If we get instantiated from code, initWithFrame: will get called.
    // If we get instantiated from a storyboard, awakeFromNib will get called.
}

- (void)awakeFromNib {
    [self setup];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self setup];
    return self;
}

#pragma mark - Properties

@synthesize faceCardScaleFactor = _faceCardScaleFactor;

- (NSString *)cardbackImagename {
    return @"cardback.png";
}

- (CGFloat)faceCardScaleFactor {
    if (!_faceCardScaleFactor) {
        _faceCardScaleFactor = DEFAULT_FACE_CARD_SCALE_FACTOR;
    }
    
    return _faceCardScaleFactor;
}

- (void)setFaceCardScaleFactor:(CGFloat)faceCardScaleFactor {
    _faceCardScaleFactor = faceCardScaleFactor;
    [self setNeedsDisplay];
}

- (void)setFaceUp:(BOOL)faceUp {
    _faceUp = faceUp;
    [self setNeedsDisplay];
}

- (void)setRank:(NSUInteger)rank {
    _rank = rank;
    [self setNeedsDisplay];
}

- (void)setSuit:(NSString *)suit {
    _suit = suit;
    [self setNeedsDisplay];
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect {
    [self drawCardWithBackImage:self.cardbackImagename];
}

- (void)drawCardWithBackImage:(NSString *)cardback {
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:CORNER_RADIUS];
    
    [roundedRect addClip];
    [[UIColor whiteColor] setFill];
    UIRectFill(self.bounds);
    
    if (self.isFaceUp) {
        NSString *cardFilename = [NSString stringWithFormat:@"%@%@", self.rankAsString, self.suit];
        UIImage *faceImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", cardFilename]];
        
        if (!faceImage) {
            faceImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg", cardFilename]];
        }
        
        if (faceImage) {
            CGRect imageRect = CGRectInset(self.bounds,
                                           self.bounds.size.width * (1.0 - self.faceCardScaleFactor),
                                           self.bounds.size.height * (1.0 - self.faceCardScaleFactor)
                                           );
            
            [faceImage drawInRect:imageRect];
        } else {
            [self drawFace];
        }
        
        [self drawCorners];
    } else {
        [[UIImage imageNamed:cardback] drawInRect:self.bounds];
    }
    
    [[UIColor blackColor] setStroke];
    [roundedRect stroke];
}

- (void)drawCorners {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    paragraphStyle.lineHeightMultiple = CORNER_LINE_HEIGHT;
    
    UIFont *cornerFont = [UIFont systemFontOfSize:self.bounds.size.width * PIP_FONT_SCALE_FACTOR];
    UIFont *cornerPipFont = [UIFont systemFontOfSize:self.bounds.size.width * PIP_FONT_SCALE_FACTOR * CORNER_PIP_SCALE_FACTOR];
    NSString *cornerString = [NSString stringWithFormat:@"%@\n%@", [self rankAsString], self.suit];
    NSMutableAttributedString *cornerText = [[NSMutableAttributedString alloc]
                                             initWithString:cornerString
                                             attributes:@{
                                                          NSParagraphStyleAttributeName : paragraphStyle,
                                                          NSFontAttributeName : cornerFont
                                                          }];
    [cornerText addAttributes:@{ NSFontAttributeName : cornerPipFont }
                        range:NSMakeRange(cornerString.length - 1, 1)];
    
    CGRect textBounds;
    textBounds.origin = CGPointMake(CORNER_X_OFFSET, CORNER_Y_OFFSET);
    textBounds.size = [cornerText size];
    [cornerText drawInRect:textBounds];
    
    [self pushContextAndRotateUpsideDown];
    [cornerText drawInRect:textBounds];
    [self popContext];
}

- (void)popContext {
    CGContextRestoreGState(UIGraphicsGetCurrentContext());
}

- (CGContextRef)pushContext {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    return context;
}

- (void)pushContextAndRotateUpsideDown {
    CGContextRef context = [self pushContext];
    CGContextTranslateCTM(context, self.bounds.size.width, self.bounds.size.height);
    CGContextRotateCTM(context, M_PI);
}

#pragma mark - Gesture handlers

- (void)pinch:(UIPinchGestureRecognizer *)gesture {
    // TODO
}

#pragma mark - Draw pips

- (void)drawFace {
    // Need center pip on 1, 3, 5, 9
    switch (self.rank) {
        case 1: case 3: case 5: case 9:
            [self drawPipsWithHorizontalOffset:0
                                verticalOffset:0
                            mirroredVertically:NO];
    }
    
    // Need pair of pips on center row for ranks 6-8
    if (self.rank >= 6 && self.rank <= 8) {
        [self drawPipsWithHorizontalOffset:PIP_HOFFSET_PERCENTAGE
                            verticalOffset:0
                        mirroredVertically:NO];
    }
    
    // Need top-center/bottom-center pip
    if ((self.rank == 2) || (self.rank == 3) || (self.rank == 7) || (self.rank == 8) || (self.rank == 10)) {
        [self drawPipsWithHorizontalOffset:0
                            verticalOffset:PIP_VOFFSET2_PERCENTAGE
                        mirroredVertically:(self.rank != 7)];
    }
    
    // Need two pair of pips on outermost row for ranks 4-10
    if (self.rank >= 4 && self.rank <= 10) {
        [self drawPipsWithHorizontalOffset:PIP_HOFFSET_PERCENTAGE
                            verticalOffset:PIP_VOFFSET3_PERCENTAGE
                        mirroredVertically:YES];
    }
    
    // Need two pair of pips on inner row for ranks 9-10
    if (self.rank >= 9 && self.rank <= 10) {
        [self drawPipsWithHorizontalOffset:PIP_HOFFSET_PERCENTAGE
                            verticalOffset:PIP_VOFFSET1_PERCENTAGE
                        mirroredVertically:YES];
    }
}

- (void)drawPipsWithHorizontalOffset:(CGFloat)hoffset
                      verticalOffset:(CGFloat)voffset
                          upsideDown:(BOOL)upsideDown {
    if (upsideDown) {
        [self pushContextAndRotateUpsideDown];
    }
    
    CGPoint middle = CGPointMake(self.bounds.size.width / 2,
                                 self.bounds.size.height / 2);
    UIFont *pipFont = [UIFont systemFontOfSize:self.bounds.size.width * PIP_FONT_SCALE_FACTOR];
    NSAttributedString *attributedSuit = [[NSAttributedString alloc]
                                          initWithString:self.suit
                                          attributes:@{ NSFontAttributeName : pipFont }];
    CGSize pipSize = [attributedSuit size];
    CGPoint pipOrigin = CGPointMake(middle.x - pipSize.width / 2.0 - hoffset * self.bounds.size.width,
                                    middle.y - pipSize.height / 2.0 - voffset * self.bounds.size.height
                                    );
    [attributedSuit drawAtPoint:pipOrigin];
    
    if (hoffset) {
        pipOrigin.x += hoffset * 2.0 * self.bounds.size.width;
        [attributedSuit drawAtPoint:pipOrigin];
    }
    
    if (upsideDown) {
        [self popContext];
    }
}

- (void)drawPipsWithHorizontalOffset:(CGFloat)hoffset
                      verticalOffset:(CGFloat)voffset
                  mirroredVertically:(BOOL)mirroredVertically {
    [self drawPipsWithHorizontalOffset:hoffset
                        verticalOffset:voffset
                            upsideDown:NO];
    
    if (mirroredVertically) {
        [self drawPipsWithHorizontalOffset:hoffset
                            verticalOffset:voffset
                                upsideDown:YES];
    }
}

@end