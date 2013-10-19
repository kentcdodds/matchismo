//
//  PlayingCardView.h
//  SuperCard
//
//  Created by Steve Liddle on 10/2/13.
//  Copyright (c) 2013 Brigham Young University. All rights reserved.
//
#import <UIKit/UIKit.h>

#pragma mark - Constants

// Made public so subclasses can use them too
#define DEFAULT_FACE_CARD_SCALE_FACTOR  0.90

#define CORNER_LINE_HEIGHT              0.8
#define CORNER_RADIUS                   (self.bounds.size.width * 0.0667)
#define CORNER_PIP_SCALE_FACTOR         0.45
#define CORNER_X_OFFSET                 (self.bounds.size.width * 0.0556)
#define CORNER_Y_OFFSET                 (self.bounds.size.width * 0.0667)

#define GESTURE_NORMAL_SCALE            1

#define PIP_FONT_SCALE_FACTOR           0.20
#define PIP_HOFFSET_PERCENTAGE          0.165
#define PIP_VOFFSET1_PERCENTAGE         0.090
#define PIP_VOFFSET2_PERCENTAGE         0.175
#define PIP_VOFFSET3_PERCENTAGE         0.270

@interface PlayingCardView : UIView

@property (readonly, strong, nonatomic) NSString *cardbackImagename;
@property (nonatomic) NSUInteger rank;
@property (strong, nonatomic) NSString *rankAsString;
@property (strong, nonatomic) NSString *suit;
@property (nonatomic, getter = isFaceUp) BOOL faceUp;

- (void)drawCardWithBackImage:(NSString *)cardback;
- (void)drawCorners;
- (void)drawFace;
- (void)pinch:(UIPinchGestureRecognizer *)gesture;
- (void)popContext;
- (CGContextRef)pushContext;
- (void)pushContextAndRotateUpsideDown;

@end