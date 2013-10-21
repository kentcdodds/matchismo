//
//  RookGame.m
//  Matchismo
//
//  Created by Steve Liddle on 10/19/13.
//  Copyright (c) 2013 Brigham Young University. All rights reserved.
//
#import "RookGame.h"
#import "RookCardDeck.h"

#define MIN_NEST_SIZE   3

@interface RookGame()
// TODO: you need the following properties:
//   numberOfPlayers (an integer)
//   nestCards (a mutable array of rook cards)
//   playerCards (a mutable array of mutable arrays of rook cards)
@end

@implementation RookGame

#pragma mark - Initialization

- (id)initWithNumberOfPlayers:(NSUInteger)numberOfPlayers {
    self = [super init];

    if (self) {
        // If numberOfPlayers is too big or too small, set self to nil and return nil
        // Create a Rook card deck (from which you can deal cards to the hands and nest)
        // Figure out the number of cards per player
        // Figure out the nest size (use the formulas I gave in the assignment description)
        // Draw cards from the deck for the nest (use the Deck helper method you implemented for this)
        // Make a mutable array as big as the numberOfPlayers
        // For each player, draw the random cards for that player and add that cards array to the mutable array
        // Save the numberOfPlayers in the property for numberOfPlayers
        // Set the highBidder property to "none"
    }

    return self;
}

#pragma mark - Getters and setters

// I recommend replacing the synthesized setHighBidder with your own setter that
// only allows values that are in range (0 to self.numberOfPlayers - 1).  If the
// value is out of range, just assign NO_HIGH_BIDDER as the value.

#pragma mark - Helpers

- (RookCard *)cardForPlayer:(NSUInteger)playerIndex atIndex:(NSUInteger)cardIndex {
    // Get the cards for the given playerIndex
    // If the cardIndex is in range, return the card at the given cardIndex
    // Otherwise return nil
    return nil;
}

// This is a helper method that doesn't need to be public
- (NSMutableArray *)cardsForPlayer:(NSUInteger)playerIndex {
    // If the playerIndex is in range, return the cards in self.playerCards[playerIndex]
    // Otherwise return nil
    return nil;
}

- (void)flipCardForPlayer:(NSUInteger)playerIndex atIndex:(NSUInteger)cardIndex {
    // Get the cardforPlayer:playerIndex atIndex:cardIndex
    // Negate the face-up property of that card
}

- (RookCard *)nestCardAtIndex:(NSUInteger)cardIndex {
    // Return the nest card at the given index (if the index is valid)
    // Otherwise return nil
    return nil;
}

- (NSUInteger)numberOfCardsInNest {
    // Return the number of cards in the nest
    // You can calculate it from the number of players property, or return the size of the
    // array of nest cards
    return 0;
}

- (NSUInteger)numberOfCardsPerPlayer {
    // Return the number of cards each player should have in his or her hand
    // Again, you can either calculate it or return an array size -- you decide
    return 0;
}

- (void)swapCard:(NSUInteger)cardIndex withNestCard:(NSUInteger)nestIndex {
    // If there is no high bidder, return without doing anything
    // If the cardIndex or nestIndex are out of range, also return without doing anything
    // Assign the high bidder's card at cardIndex to a temporary variable
    // Assign the nest card at nestIndex to the high bidder's hand at cardIndex
    // Assign the temporary variable to the nest at nestIndex
    // Sort the nestCards and high bidder's playerCards arrays again
    //    You'll want sortedArrayUsingSelector, and you'll want mutableCopy
    //    Assign the sorted, mutable copies back to the properties
    NSArray *array;
    SEL mySelector = @selector(numberOfCardsPerPlayer);
    
    [array performSelectorOnMainThread:mySelector withObject:self waitUntilDone:YES];
    
    [array sortedArrayUsingSelector:mySelector];
}

@end