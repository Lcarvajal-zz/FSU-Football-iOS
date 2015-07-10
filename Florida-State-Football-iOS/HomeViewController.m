//
//  FirstViewController.m
//  Florida-State-Football-iOS
//
//  Created by Lukas Carvajal on 7/10/15.
//  Copyright (c) 2015 Lukas Carvajal. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()
@property (strong, nonatomic) IBOutlet UIWebView *movieWebView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // set garnet color nav controller
    [[UITabBar appearance] setTintColor:[UIColor colorWithRed: 100.0/255.0f green:32.0/255.0f blue:49.0/255.0f alpha:1.0]];
    
    // Radio URL.
    NSString *streamFromURL = @"http://mobile.cs.fsu.edu/php/files/ios/HypeVideo.mp4";
    
    // Convert URL to String.
    NSURL *url = [NSURL URLWithString:streamFromURL];
    
    // Handle request.
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // Load content into web view.
    [self.movieWebView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
