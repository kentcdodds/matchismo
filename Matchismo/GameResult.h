//
//  GameResult.h
//  Matchismo
//
//  Created by Steve Liddle on 9/25/13.
//  Copyright (c) 2013 Brigham Young University. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface GameResult : NSObject

+ (NSArray *)allGameResults; // of GameResults

@property (readonly, nonatomic) NSDate *start;
@property (readonly, nonatomic) NSDate *end;
@property (readonly, nonatomic) NSTimeInterval duration;
@property (nonatomic) NSInteger score;

- (NSComparisonResult)compareDate:(GameResult *)aGameResult;
- (NSComparisonResult)compareDuration:(GameResult *)aGameResult;
- (NSComparisonResult)compareScore:(GameResult *)aGameResult;

@end