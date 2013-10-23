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

@property (nonatomic) NSUInteger numberOfPlayers;
@property (nonatomic) NSUInteger numberOfCardsPerPlayer;
@property (strong, nonatomic) NSMutableArray *nestCards;
@property (strong, nonatomic) NSMutableArray *playerCards;

@end

@implementation RookGame

#pragma mark - Initialization

- (id)initWithNumberOfPlayers:(NSUInteger)numberOfPlayers {
    self = [super init];
    
    if (self) {
        _numberOfPlayers = numberOfPlayers;
        RookCardDeck *deck = [[RookCardDeck alloc] init];
        _numberOfCardsPerPlayer = (4 * 14 + 1) / numberOfPlayers;
        NSInteger nestSize = 57 % numberOfPlayers;
        if (nestSize < 3) {
            nestSize += numberOfPlayers;
            --_numberOfCardsPerPlayer;
        }
        self.nestCards = [deck drawRandomCards:57];
        self.playerCards = [[NSMutableArray alloc] initWithCapacity:numberOfPlayers];
        for (int i = 0; i < numberOfPlayers; i++) {
            NSMutableArray *playerCards = [[NSMutableArray alloc] init];
            for (int j = 0; j < _numberOfCardsPerPlayer; j++) {
                NSUInteger randomIndex = arc4random() % [self.nestCards count];
                
                [playerCards addObject:self.nestCards[randomIndex]];
                [self.nestCards removeObjectAtIndex:randomIndex];
            }
            [self.playerCards addObject:[self sortCards:playerCards]];
        }
        self.highBidder = NO_HIGH_BIDDER;
    }

    return self;
}

#pragma mark - Getters and setters

- (void)setHighBidder:(NSInteger)playerIndex {
    if (playerIndex > self.numberOfPlayers) {
        playerIndex = NO_HIGH_BIDDER;
    }
    _highBidder = playerIndex;
}

#pragma mark - Helpers

- (RookCard *)cardForPlayer:(NSUInteger)playerIndex atIndex:(NSUInteger)cardIndex {
    NSArray *playersCards = [self cardsForPlayer:playerIndex];
    if (cardIndex + 1 < [playersCards count]) {
        return playersCards[cardIndex];
    }
    return nil;
}

// This is a helper method that doesn't need to be public
- (NSMutableArray *)cardsForPlayer:(NSUInteger)playerIndex {
    if (playerIndex + 1 < self.numberOfPlayers) {
        return self.playerCards[playerIndex];
    }
    return nil;
}

- (void)flipCardForPlayer:(NSUInteger)playerIndex atIndex:(NSUInteger)cardIndex {
    [self cardForPlayer:playerIndex atIndex:cardIndex].faceUp = ![self cardForPlayer:playerIndex atIndex:cardIndex].faceUp;
}

- (RookCard *)nestCardAtIndex:(NSUInteger)cardIndex {
    if (cardIndex + 1 < [self numberOfCardsInNest]) {
        return self.nestCards[cardIndex];
    }
    return nil;
}

- (NSUInteger)numberOfCardsInNest {
    return [self.nestCards count];
}

- (NSUInteger)numberOfCardsPerPlayer {
    return _numberOfCardsPerPlayer;
}

- (void)swapCard:(NSUInteger)cardIndex withNestCard:(NSUInteger)nestIndex {
    if (self.highBidder == NO_HIGH_BIDDER) {
        return;
    }
    
    NSMutableArray *highBidderCards = [self cardsForPlayer:self.highBidder];
    RookCard *nestCard = [self nestCardAtIndex:nestIndex];
    RookCard *card = highBidderCards[cardIndex];
    if (nestCard == nil || card == nil) {
        return;
    }
    
    // Remove cards
    [highBidderCards removeObject:card];
    [self.nestCards removeObject:nestCard];
    
    // Add cards
    [self.nestCards addObject:card];
    [highBidderCards addObject:nestCard];
    
    // Sort cards
    self.nestCards = [self sortCards:self.nestCards];
    self.playerCards[self.highBidder] = [self sortCards:highBidderCards];
}

-(NSMutableArray *)sortCards:(NSMutableArray *)cards {
    SEL selector = @selector(compareCard:);
    NSArray *sortedArray = [cards sortedArrayUsingSelector:selector];
    return [sortedArray mutableCopy];
}

@end