//
//  RadioViewController.m
//  Florida-State-Football-iOS
//
//  Created by Lukas Carvajal on 7/10/15.
//  Copyright (c) 2015 Lukas Carvajal. All rights reserved.
//

#import "RadioViewController.h"

@interface RadioViewController ()


@property (strong, nonatomic) IBOutlet UIWebView *radioWebView;
- (IBAction)playRadioButton:(id)sender;

@end

@implementation RadioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)playRadioButton:(id)sender {
    
    // Radio URL.
    NSString *streamFromURL = @"http://voice.wvfs.fsu.edu:8000/stream.m3u";
    
    // Convert URL to String.
    NSURL *url = [NSURL URLWithString:streamFromURL];
    
    // Handle request.
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // Load content into web view.
    [self.radioWebView loadRequest:request];
}
@end
