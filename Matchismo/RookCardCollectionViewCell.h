//
//  RookCardCollectionViewCell.h
//  Matchismo
//
//  Created by Kent Dodds on 10/16/13.
//  Copyright (c) 2013 Kent C. Dodds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RookCardView.h"

@interface RookCardCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet RookCardView *rookCardView;

@end