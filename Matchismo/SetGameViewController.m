//
//  SetGameViewController.m
//  Matchismo
//
//  Created by Kent Dodds on 9/30/13.
//  Copyright (c) 2013 Kent C. Dodds. All rights reserved.
//

#import "SetGameViewController.h"

@interface SetGameViewController ()


@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *resultsLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@end

@implementation SetGameViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

@end
