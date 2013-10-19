//
//  PlayingCardCollectionViewCell.h
//  Matchismo
//
//  Created by Steve Liddle on 10/14/13.
//  Copyright (c) 2013 Brigham Young University. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "PlayingCardView.h"

@interface PlayingCardCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet PlayingCardView *playingCardView;

@end