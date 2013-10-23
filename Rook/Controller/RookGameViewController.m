//
//  RookGameViewController.m
//  Matchismo
//
//  Created by Steve Liddle on 10/16/13.
//  Copyright (c) 2013 Brigham Young University. All rights reserved.
//
#import "RookGameViewController.h"
#import "RookGame.h"
#import "RookCardCollectionViewCell.h"

#define NO_SELECTION            -1
#define PLAYERS_CARDS_SECTION   0
#define NEST_CARDS_SECTION      1

@interface RookGameViewController () <UICollectionViewDataSource>

@property (nonatomic) NSUInteger currentPlayerIndex;
@property (strong, nonatomic, getter = rookGame) RookGame *rookGame;
@property (nonatomic) NSInteger selectedCardIndex;
@property (nonatomic) NSInteger nestSelectedCardIndex;
@property (weak, nonatomic) IBOutlet RookCardView *cardCollectionView;

@end

@implementation RookGameViewController

@synthesize rookGame = _rookGame;

-(id)init {
    self = [super init];
    if (self) {
    }
    return self;
}

-(void)viewDidLoad {
    self.currentPlayerIndex = 0;
    self.selectedCardIndex = NO_SELECTION;
    self.nestSelectedCardIndex = NO_SELECTION;
}

#pragma mark - Getters and setters

-(RookGame *)rookGame {
    if (!_rookGame) {
        _rookGame = [[RookGame alloc] initWithNumberOfPlayers:self.numberOfPlayers];
    }
    return _rookGame;
}

#pragma mark - Helpers

- (void)clearSelection {
    if (self.selectedCardIndex != NO_SELECTION) {
        [self.rookGame cardForPlayer:self.currentPlayerIndex atIndex:self.selectedCardIndex].selected = NO;
    }
    if (self.nestSelectedCardIndex != NO_SELECTION) {
        [self.rookGame nestCardAtIndex:self.nestSelectedCardIndex].selected = NO;
    }
    self.selectedCardIndex = NO_SELECTION;
    self.nestSelectedCardIndex = NO_SELECTION;
}

-(BOOL)currentPlayerIsHighBidder {
    return self.currentPlayerIndex == self.rookGame.highBidder;
}

#pragma mark - Actions

- (IBAction)designateHighBidder:(UIBarButtonItem *)sender {
    if (self.rookGame.highBidder == NO_HIGH_BIDDER) {
        sender.title = @"Quit Game";
        
        [self.rookGame setHighBidder:self.currentPlayerIndex];
        [self.collectionView reloadData];
    } else {
        sender.title = @"High Bidder";
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (IBAction)flipCard:(UISwipeGestureRecognizer *)gesture {
    CGPoint location = [gesture locationInView:self.collectionView];
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:location];
    
    if (indexPath) {
        [self.rookGame flipCardForPlayer:self.currentPlayerIndex atIndex:indexPath.item];
        [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
    }
}

- (IBAction)nextPlayer:(UIBarButtonItem *)sender {
    [self clearSelection];
    NSUInteger nextPlayerIndex = self.currentPlayerIndex + 1;
    if (nextPlayerIndex > self.numberOfPlayers - 1) {
        nextPlayerIndex = 0;
    }
    self.currentPlayerIndex = nextPlayerIndex;
    self.title = [NSString stringWithFormat:@"Player %d", self.currentPlayerIndex + 1];
    [self.collectionView reloadData];
}

- (IBAction)selectCard:(UITapGestureRecognizer *)gesture {
    if (![self currentPlayerIsHighBidder]) {
        return; // ignore the tap...
    }
    CGPoint tapLocation = [gesture locationInView:self.collectionView];
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:tapLocation];

    if (indexPath) {
        if (indexPath.section == PLAYERS_CARDS_SECTION) {
            if (self.selectedCardIndex == indexPath.item) {
                [self clearSelection];
            } else if (self.nestSelectedCardIndex != NO_SELECTION) {
                self.selectedCardIndex = indexPath.item;
                NSInteger cardIndex = self.selectedCardIndex;
                NSInteger nestIndex = self.nestSelectedCardIndex;
                [self clearSelection];
                [self.rookGame swapCard:nestIndex withNestCard:cardIndex];
            } else {
                [self clearSelection];
                self.selectedCardIndex = indexPath.item;
                [self.rookGame cardForPlayer:self.currentPlayerIndex atIndex:self.selectedCardIndex].selected = YES;
            }
        } else {
            if (self.nestSelectedCardIndex == indexPath.item) {
                [self clearSelection];
            } else if (self.selectedCardIndex != NO_SELECTION) {
                self.nestSelectedCardIndex = indexPath.item;
                NSInteger cardIndex = self.selectedCardIndex;
                NSInteger nestIndex = self.nestSelectedCardIndex;
                [self clearSelection];
                [self.rookGame swapCard:cardIndex withNestCard:nestIndex];
            } else {
                [self clearSelection];
                self.nestSelectedCardIndex = indexPath.item;
                [self.rookGame nestCardAtIndex:self.nestSelectedCardIndex].selected = YES;
            }
        }
        [self.collectionView reloadData];
    }
}

#pragma mark - Collection view data source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self currentPlayerIsHighBidder] ? 2 : 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RookCardCollectionViewCell *cell = (RookCardCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"RookCardCell" forIndexPath:indexPath];
    RookCard *card = [self.rookGame cardForPlayer:self.currentPlayerIndex atIndex:indexPath.item];
    if (indexPath.section == NEST_CARDS_SECTION) {
        card = [self.rookGame nestCardAtIndex:indexPath.item];
    }
    if (card) {
        [self updateCell:cell usingCard:card];
    }
    return cell;
}

- (RookCardView *)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card {
    RookCardView *rookCardView = ((RookCardCollectionViewCell *)cell).rookCardView;
    
    RookCard *rookCard = (RookCard *)card;

    rookCardView.rank = rookCard.rank;
    rookCardView.rankAsString = [RookCard validRanks][rookCard.rank];
    rookCardView.suit = rookCard.suit;
    rookCardView.suitName = [RookCard validSuitNames][[[RookCard validSuits] indexOfObject:rookCard.suit]];
    rookCardView.faceUp = rookCard.isFaceUp;
    rookCardView.selected = rookCard.selected;
    return rookCardView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return section == PLAYERS_CARDS_SECTION ? [self.rookGame numberOfCardsPerPlayer] : [self.rookGame numberOfCardsInNest];
}

@end