//
//  RookGameViewController.m
//  Matchismo
//
//  Created by Steve Liddle on 10/16/13.
//  Copyright (c) 2013 Brigham Young University. All rights reserved.
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