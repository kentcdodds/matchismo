//
//  RookCardView.h
//  SuperCard
//
//  Created by Steve Liddle on 10/7/13.
//  Copyright (c) 2013 Brigham Young University. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface RookCardView : UIView

@property (nonatomic, getter = isFaceUp) BOOL faceUp;
@property (nonatomic) NSUInteger rank;
@property (strong, nonatomic) NSString *rankAsString;
@property (nonatomic, getter = isSelected) BOOL selected;
@property (strong, nonatomic) NSString *suit;
@property (strong, nonatomic) NSString *suitName;

@end