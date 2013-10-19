//
//  GameResultsViewController.m
//  Matchismo
//
//  Created by Steve Liddle on 9/25/13.
//  Copyright (c) 2013 Brigham Young University. All rights reserved.
//
#import "GameResultsViewController.h"
#import "GameResult.h"

@interface GameResultsViewController ()
@property (weak, nonatomic) IBOutlet UITextView *display;
@property (strong, nonatomic) NSArray *allGameResults;
@end

@implementation GameResultsViewController

#pragma mark - Initialization

- (void)setup {
    // Do any initialization we might need
    // NOTE: this code is here to show you the proper pattern for initializing
    // a UIViewController if you want to override its designated initializer.
}

- (void)awakeFromNib {
    [self setup];
}

// designated initializer for UIViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    [self setup];
    return self;
}

#pragma mark - View controller lifecycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.allGameResults = [GameResult allGameResults];
    [self updateUI];
}

#pragma mark - Helpers

- (void)updateUI {
    NSString *displayText = @"";

    for (GameResult *result in self.allGameResults) {
        displayText = [displayText stringByAppendingFormat:@"Score: %d, (%@, %gs)\n",
                       result.score,
                       [NSDateFormatter localizedStringFromDate:result.end
                                                      dateStyle:NSDateFormatterShortStyle
                                                      timeStyle:NSDateFormatterShortStyle],
                       round(result.duration)];
    }

    self.display.text = displayText;
}

#pragma mark - Actions

- (IBAction)sortByDate {
    self.allGameResults = [self.allGameResults sortedArrayUsingSelector:@selector(compareDate:)];
    [self updateUI];
}

- (IBAction)sortByDuration {
    self.allGameResults = [self.allGameResults sortedArrayUsingSelector:@selector(compareDuration:)];
    [self updateUI];
}

- (IBAction)sortByScore {
    self.allGameResults = [self.allGameResults sortedArrayUsingSelector:@selector(compareScore:)];
    [self updateUI];
}

@end