//
//  SetGameViewController.m
//  Matchismo
//
//  Created by Kent Dodds on 9/30/13.
//  Copyright (c) 2013 Kent C. Dodds. All rights reserved.
//

#import "SetGameViewController.h"
#import "SetDeck.h"
#import "CardMatchingGame.h"

@interface SetGameViewController ()

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@property (strong, nonatomic) CardMatchingGame *game;

@end

@implementation SetGameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateUI];
}

- (void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
}

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        
        [cardButton setTitle:card.contents forState:UIControlStateHighlighted | UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateHighlighted];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateNormal];
        
        cardButton.selected = card.isActive;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = (card.isUnplayable ? 0.1 : 1.0);
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    
    NSString *resultText = @"Select a set!";
    if (self.game.recentActionResult) {
        resultText = self.game.recentActionResult;
    }
    self.resultLabel.text = resultText;
    // All of this crazy stuff below to make it not lose it's width...
    self.resultLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.resultLabel setNumberOfLines:0];
    [self.resultLabel sizeToFit];
    
    CGRect resultLabelFrame = self.resultLabel.frame;
    resultLabelFrame = CGRectMake(resultLabelFrame.origin.x, resultLabelFrame.origin.y, 280, resultLabelFrame.size.height);
    self.resultLabel.frame = resultLabelFrame;
}
- (CardMatchingGame *)game
{
    if (!_game) {
        NSUInteger totalCards = [self.cardButtons count];
        SetDeck *deck = [[SetDeck alloc] init];
        _game = [[CardMatchingGame alloc] initWithCardCount:totalCards usingDeck:deck];
        _game.cardsToMatch = 3;
        
    }
    return _game;
}

- (IBAction)toggleActive:(UIButton *)sender
{
    [self.game activateCardAtIndex:[self.cardButtons indexOfObject:sender]];
    [self updateUI];
}


- (IBAction)redeal:(id)sender
{
    _game = nil;
    [self updateUI];
    
}

@end
