//
//  RookCardCollectionViewCell.h
//  Matchismo
//
//  Created by Steve Liddle on 10/14/13.
//  Copyright (c) 2013 Brigham Young University. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "RookCardView.h"

@interface RookCardCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet RookCardView *rookCardView;

@end