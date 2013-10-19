//
//  CardGameViewController.h
//  Matchismo
//
//  Created by Steve Liddle on 9/11/13.
//  Copyright (c) 2013 Brigham Young University. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "Deck.h"

#define CARD_DISABLED_ALPHA     0.3
#define CARD_ENABLED_ALPHA      1.0

@interface CardGameViewController : UIViewController

// "Abstract" methods and properties that subclasses should implement
- (Deck *)createDeck;
- (void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card;
@property (strong, nonatomic) NSString *cardReuseIdentifier;
@property (nonatomic) NSUInteger startingCardCount;

@end