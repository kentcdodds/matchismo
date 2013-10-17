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

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;


@property (strong, nonatomic) CardMatchingGame *game;

@end

@implementation CardGameViewController

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
    UIImage* steveImage = [UIImage imageNamed:@"steve"];
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];

        if (!card.faceUp) {
            [cardButton setBackgroundImage:steveImage forState:UIControlStateNormal];
        } else {
            [cardButton setBackgroundImage:nil forState:UIControlStateNormal];
        }
        cardButton.selected = card.faceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = (card.isUnplayable ? 0.3 : 1.0);
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];

    NSString *resultText = @"Flip a card!";
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
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[[PlayingCardDeck alloc] init]];

    }
    return _game;
}

- (IBAction)flipCard:(UIButton *)sender
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
