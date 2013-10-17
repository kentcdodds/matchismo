//
//  RookSetupViewController.m
//  Matchismo
//
//  Created by Kent Dodds on 10/16/13.
//  Copyright (c) 2013 Kent C. Dodds. All rights reserved.
//

#import "RookSetupViewController.h"
#import "RookGameViewController.h"

@interface RookSetupViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *numberOfPlayersSegment;
@end

@implementation RookSetupViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[RookGameViewController class]]) {
        RookGameViewController *vc = (RookGameViewController *)segue.destinationViewController;
        
        vc.numberOfPlayers = self.numberOfPlayersSegment.selectedSegmentIndex + 2;
    }
}

@end