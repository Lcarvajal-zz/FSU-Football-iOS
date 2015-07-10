//
//  ArticleViewController.m
//  FSU-Football
//
//  Created by Lukas Carvajal on 7/4/15.
//  Copyright (c) 2015 Lukas Carvajal. All rights reserved.
//

#import "ArticleViewController.h"

@interface ArticleViewController ()

@property (strong, nonatomic) IBOutlet UIWebView *articleView;

- (IBAction)backButtonAction:(id)sender;

@end

@implementation ArticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_articleView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.articleURL]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButtonAction:(id)sender {
    
    NSLog(@"back");
    
    // Go back to all news articles on FSU Football.
    [self dismissViewControllerAnimated:YES completion:^{}];
}
@end
