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
@property BOOL playing;

@property (strong, nonatomic) IBOutlet UIButton *playButton;
- (IBAction)playRadioButton:(id)sender;

@end

@implementation RadioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.playing = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)playRadioButton:(id)sender {
    
    if (!self.playing) {
        
        self.playing = YES;
        
        // Set button to pause.
        [self.playButton setBackgroundImage:[UIImage imageNamed:@"pause-button.png"]
                            forState:UIControlStateNormal];
        
        // Radio URL.
        NSString *streamFromURL = @"http://voice.wvfs.fsu.edu:8000/stream.m3u";
    
        // Convert URL to String.
        NSURL *url = [NSURL URLWithString:streamFromURL];
    
        // Handle request.
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
        // Load content into web view.
        [self.radioWebView loadRequest:request];
    }
    else {
        
        self.playing = NO;
        
        // Set button to unpause.
        [self.playButton setBackgroundImage:[UIImage imageNamed:@"play-button.png"]
                                   forState:UIControlStateNormal];
        // No URL.
        NSString *streamFromURL = @"";
        
        // Convert URL to String.
        NSURL *url = [NSURL URLWithString:streamFromURL];
        
        // Handle request.
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        // Load content into web view.
        [self.radioWebView loadRequest:request];
    }
}
@end
