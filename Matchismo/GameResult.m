//
//  GameResult.m
//  Matchismo
//
//  Created by Steve Liddle on 9/25/13.
//  Copyright (c) 2013 Brigham Young University. All rights reserved.
//
#import "GameResult.h"

#define ALL_RESULTS_KEY @"GameResult_All"
#define END_KEY         @"EndDate"
#define SCORE_KEY       @"Score"
#define START_KEY       @"StartDate"

@interface GameResult()
@property (readwrite, nonatomic) NSDate *start;
@property (readwrite, nonatomic) NSDate *end;
@end

@implementation GameResult

#pragma mark - Initialization

// designated initializer
- (id)init {
    self = [super init];
    
    if (self) {
        _start = [NSDate date];
        _end = _start;
    }
    
    return self;
}

// convenience initializer
- (id)initFromPropertyList:(id)plist {
    self = [self init];
    
    if (self) {
        if ([plist isKindOfClass:[NSDictionary class]]) {
            NSDictionary *resultDictionary = (NSDictionary *)plist;

            _start = resultDictionary[START_KEY];
            _end = resultDictionary[END_KEY];
            _score = [resultDictionary[SCORE_KEY] integerValue];

            if (!_start || !_end) {
                self = nil;
            }
        }
    }

    return self;
}

#pragma mark - Getters and setters

- (NSTimeInterval)duration {
    return [self.end timeIntervalSinceDate:self.start];
}

- (void)setScore:(NSInteger)score {
    _score = score;
    self.end = [NSDate date];
    [self synchronize];
}

#pragma mark - Class methods

+ (NSArray *)allGameResults {
    NSMutableArray *allGameResults = [[NSMutableArray alloc] init];
    
    for (id plist in [[[NSUserDefaults standardUserDefaults] dictionaryForKey:ALL_RESULTS_KEY] allValues]) {
        GameResult *result = [[GameResult alloc] initFromPropertyList:plist];
        [allGameResults addObject:result];
    }
    
    return allGameResults;
}

#pragma mark - Helpers

- (id)asPropertyList {
    return @{ START_KEY : self.start, END_KEY : self.end, SCORE_KEY : @(self.score) };
}

- (NSComparisonResult)compareDate:(GameResult *)aGameResult {
    return [self.end compare:aGameResult.end];
}

- (NSComparisonResult)compareDuration:(GameResult *)aGameResult {
    return [@(self.duration) compare:@(aGameResult.duration)];
}

- (NSComparisonResult)compareScore:(GameResult *)aGameResult {
    return [@(self.score) compare:@(aGameResult.score)];
}

- (void)synchronize {
    NSMutableDictionary *mutableGameResultsFromUserDefaults =
    [[[NSUserDefaults standardUserDefaults] dictionaryForKey:ALL_RESULTS_KEY] mutableCopy];
    
    if (!mutableGameResultsFromUserDefaults) {
        mutableGameResultsFromUserDefaults = [[NSMutableDictionary alloc] init];
    }

    mutableGameResultsFromUserDefaults[[self.start description]] = [self asPropertyList];

    [[NSUserDefaults standardUserDefaults] setObject:mutableGameResultsFromUserDefaults forKey:ALL_RESULTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end