//
//  RookGameViewController.m
//  Matchismo
//
//  Created by Kent Dodds on 10/16/13.
//  Copyright (c) 2013 Kent C. Dodds. All rights reserved.
//

#import "RookGameViewController.h"

@interface RookGameViewController ()

@end

@implementation RookGameViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSLog(@"Number of players: %d", self.numberOfPlayers);
}

- (IBAction)nextPlayer:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end