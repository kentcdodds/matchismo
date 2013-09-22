//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Kent Dodds on 9/21/13.
//  Copyright (c) 2013 Kent C. Dodds. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()

@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

@property (strong, nonatomic) CardMatchingGame *game;

@end

@implementation CardGameViewController

- (void)viewDidLoad
{
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
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = (card.isUnplayable ? 0.3 : 1.0);
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];

    NSString *resultText = @"Flip a card!";
    if (self.game.recentActionResult) {
        resultText = self.game.recentActionResult;
    }
    self.resultLabel.text = resultText;
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
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[[PlayingCardDeck alloc] init]];

    }
    return _game;
}

- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", flipCount];
}

- (IBAction)flipCard:(UIButton *)sender
{
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];
    
}
- (IBAction)redeal:(id)sender {
    _game = nil;
    [self setFlipCount:0];
    [self updateUI];
}

@end
