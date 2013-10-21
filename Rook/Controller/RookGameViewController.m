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

#define NO_SELECTION    -1

@interface RookGameViewController () <UICollectionViewDataSource> // You need to declare that you implement the collection view data source protocol here
// You need several properties:
// The current player index (an unsigned integer)
// The Rook game model object (RookGame)
// The currently selected card (optional integer -- this can be done other ways too, but my pseudocode assumes it)
@end

@implementation RookGameViewController

#pragma mark - Getters and setters

// TODO: Write a lazy initializer for game that calls alloc/initWithNumberOfPlayers
//    Also set the _selectedCard instance variable to NO_SELECTION here

#pragma mark - Helpers

- (void)clearSelection {
    // If there is a currently selected card, set the current player's card at the selectedCard index
    //     to have a selected property of NO (that is, unselect the card in the model)
    // Also set the selectedCard property to NO_SELECTION
}

#pragma mark - Actions

- (IBAction)designateHighBidder:(UIBarButtonItem *)sender {
    // Set the left navigation item to nil
    // Set the model's (game's) high bidder property to the currentPlayer index
    // Tell the collection view (self.collectionView) to reload its data so the nest will appear
}

- (IBAction)flipCard:(UISwipeGestureRecognizer *)gesture {
    // This is the recipe we implemented before
    CGPoint location = [gesture locationInView:self.collectionView];
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:location];
    
    if (indexPath) {
        // Tell the model to flip the card for the currentPlayer at the given indexPath
        // Also tell the collection view to reload the item at that indexPath
    }
}

- (IBAction)nextPlayer:(UIBarButtonItem *)sender {
    // Use the clearSelection helper to clear the current selection
    // Increment the currentPlayer index, and if it's too big wrap it around to 0
    // Set this MVC's title to the string "Player N", where N is currentPlayer + 1
    // Reload the collection view data so the next player's cards will appear
}

- (IBAction)selectCard:(UITapGestureRecognizer *)gesture {
    // Again, this is the recipe we implemented before to find the indexPath of the tapped card
    CGPoint tapLocation = [gesture locationInView:self.collectionView];
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:tapLocation];

    if (indexPath) {
        // If the current player is the high bidder, do this:
        //   1. If the indexPath section is 0, it's a tap in the player's hand
        //      a) Remember in a BOOL variable whether the selectedCard is the one that just got tapped
        //      b) Clear the current selection (call the clearSelection helper)
        //      c) If the answer to 1a) was YES, set the self.selectedCard to the indexPath.item
        //            and set the selected property on that card in the model to be YES
        //   2. Otherwise it's a tap in the nest
        //      a) Remember the selectedCard index in a local variable
        //      b) Clear the current selection
        //      c) Tell the model to swap the card at the position from 2a) with the nest card the
        //            user just tapped
        //   3. In either case, reload the collection view's data to reflect the model changes
        // Otherwise ignore the tap
    }
}

#pragma mark - Collection view data source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    // If the current player is the high bidder, you need two sections
    // Otherwise you only need one section
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    // Dequeue a reusable cell with the identifier you've specified in your storyboard for this cell
    // Find the rook card from the model for the given index path
    //     Note that if the section is 0, you want to look up a card for the currentPlayer
    //     Otherwise you want to look up a card from the nest
    // Configure the RookCardView for your cell to have the rank, rankAsString, suit, suitName,
    //     faceUp, and selected properties defined by the model card (this is a lot like the
    //     updateCell:usingCard: method from Matchismo)
    // Return the cell you dequeued and configured
    
    /*
     * Here is the updateCell:usingCard: method from Matchismo.  You don't necessarily need
     * introspection for HW 3, and you don't have an alpha property to set anymore.  Instead
     * you have a selected property.

     - (void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card {
         if ([cell isKindOfClass:[RookCardCollectionViewCell class]]) {
             RookCardView *rookCardView = ((RookCardCollectionViewCell *)cell).rookCardView;
     
             if ([card isKindOfClass:[RookCard class]]) {
                 RookCard *rookCard = (RookCard *)card;
     
                 rookCardView.rank = rookCard.rank;
                 rookCardView.rankAsString = [RookCard validRanks][rookCard.rank];
                 rookCardView.suit = rookCard.suit;
                 rookCardView.suitName = [RookCard validSuitNames][[[RookCard validSuits] indexOfObject:rookCard.suit]];
                 rookCardView.faceUp = rookCard.isFaceUp;
                 rookCardView.alpha = rookCard.isUnplayable ? CARD_DISABLED_ALPHA : CARD_ENABLED_ALPHA;
             }
         }
     }

     */
    return nil;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    // If the section is the player's cards, return the number of cards per player from the model
    // Otherwise return the number of cards in the nest (again, the model can tell you this number)
    return 0;
}

@end