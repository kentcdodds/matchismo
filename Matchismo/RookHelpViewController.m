//
//  RookHelpViewController.m
//  Matchismo
//
//  Created by Kent Dodds on 10/16/13.
//  Copyright (c) 2013 Kent C. Dodds. All rights reserved.
//

#import "RookHelpViewController.h"

@interface RookHelpViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation RookHelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"Help" ofType:@"html"];
    NSString *htmlText = [NSString stringWithContentsOfFile:htmlFile
                                                   encoding:NSUTF8StringEncoding
                                                      error:nil];
    [self.webView loadHTMLString:htmlText baseURL:nil];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://home.byu.edu"]]];
}

- (IBAction)doneWithHelp {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end