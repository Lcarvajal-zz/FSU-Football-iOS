//
//  ScoresTableViewController.m
//  Florida-State-Football-iOS
//
//  Created by Lukas Carvajal on 7/10/15.
//  Copyright (c) 2015 Lukas Carvajal. All rights reserved.
//

#import "ScoresTableViewController.h"
#import "FSUGame.h"

@interface ScoresTableViewController ()

@property NSMutableArray *array;

@end

@implementation ScoresTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!_array)
        _array = [[NSMutableArray alloc] init];
    
    NSLog(@"hello");
    
    [self loadFSUSchedule];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Load data.

- (void) loadFSUSchedule {
    
    // Initialize.
    FSUGame *game1 = [[FSUGame alloc] init];
    FSUGame *game2 = [[FSUGame alloc] init];
    FSUGame *game3 = [[FSUGame alloc] init];
    FSUGame *game4 = [[FSUGame alloc] init];
    FSUGame *game5 = [[FSUGame alloc] init];
    FSUGame *game6 = [[FSUGame alloc] init];
    FSUGame *game7 = [[FSUGame alloc] init];
    FSUGame *game8 = [[FSUGame alloc] init];
    FSUGame *game9 = [[FSUGame alloc] init];
    FSUGame *game10 = [[FSUGame alloc] init];
    FSUGame *game11 = [[FSUGame alloc] init];
    FSUGame *game12 = [[FSUGame alloc] init];
    
    // Set opponent names.
    game1.opponent = @"Texas State";
    game2.opponent = @"USF";
    game3.opponent = @"at Boston College";
    game4.opponent = @"at Wake Forest";
    game5.opponent = @"Miami";
    game6.opponent = @"Louisville";
    game7.opponent = @"at Georgia Tech";
    game8.opponent = @"Syracuse";
    game9.opponent = @"at Clemson";
    game10.opponent = @"NC State";
    game11.opponent = @"Chattanooga";
    game12.opponent = @"at Florida";
    
    // Set dates.
    game1.date = @"Sat, Sep 05";
    game2.date = @"Sat, Sep 12";
    game3.date = @"Fri, Sep 18";
    game4.date = @"Sat, Oct 03";
    game5.date = @"Sat, Oct 10";
    game6.date = @"Sat, Oct 17";
    game7.date = @"Sat, Oct 24";
    game8.date = @"Sat, Oct 31";
    game9.date = @"Sat, Nov 07";
    game10.date = @"Sat, Nov 14";
    game11.date = @"Sat, Nov 21";
    game12.date = @"Sat, Nov 28";
    
    // Set whether game is played at home or not.
    game1.home = YES;
    game2.home = YES;
    game3.home = NO;
    game4.home = NO;
    game5.home = YES;
    game6.home = YES;
    game7.home = NO;
    game8.home = YES;
    game9.home = NO;
    game10.home = YES;
    game11.home = YES;
    game12.home = NO;
    
    // Set image name for opponent.
    game1.imageName = @"TS";
    game2.imageName = @"USF";
    game3.imageName = @"BC";
    game4.imageName = @"WF";
    game5.imageName = @"UM";
    game6.imageName = @"Lou";
    game7.imageName = @"GT";
    game8.imageName = @"Syr";
    game9.imageName = @"Cle";
    game10.imageName = @"NCS";
    game11.imageName = @"Cha";
    game12.imageName = @"UF";
    
    // Add objects to array.
    [self.array addObject:game1];
    [self.array addObject:game2];
    [self.array addObject:game3];
    [self.array addObject:game4];
    [self.array addObject:game5];
    [self.array addObject:game6];
    [self.array addObject:game7];
    [self.array addObject:game8];
    [self.array addObject:game9];
    [self.array addObject:game10];
    [self.array addObject:game11];
    [self.array addObject:game12];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    return self.array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    FSUGame *game = [self.array objectAtIndex:indexPath.row];
    
    // Get opponent image for game.
    UIImage *image = [UIImage imageNamed:game.imageName];
    UIImage *homeImage = [UIImage imageNamed:@"FSU"];
    UIImageView *opponentImageView;
    UIImageView *homeImageView;
    
    // Set game details.
    UILabel *gameNameLabel = (UILabel *)[cell viewWithTag:102];
    gameNameLabel.text = game.opponent;
    
    UILabel *gameDateLabel = (UILabel *)[cell viewWithTag:103];
    gameDateLabel.text = game.date;
    
    if (game.home) {
        
        // Garnet Background for home games.
        cell.backgroundColor = [UIColor colorWithRed: 100.0/255.0f green:32.0/255.0f blue:49.0/255.0f alpha:1.0];
        
        // Opponent image on right.
        opponentImageView = (UIImageView *)[cell viewWithTag:101];
        
        // FSU image on left.
        homeImageView = (UIImageView *)[cell viewWithTag:100];
        
        // White text color for home colors.
        gameNameLabel.textColor = [UIColor whiteColor];
        gameDateLabel.textColor = [UIColor whiteColor];
    }
    else {
        
        // White cell background for away games.
        cell.backgroundColor = [UIColor whiteColor];

        // Opponent image on left for away games.
        opponentImageView = (UIImageView *)[cell viewWithTag:100];
        
        // FSU image on right for away games.
        homeImageView = (UIImageView *)[cell viewWithTag:101];
        
        // Black text color for home colors.
        gameNameLabel.textColor = [UIColor blackColor];
        gameDateLabel.textColor = [UIColor blackColor];
    }
    
    // Set opponent image in cell.
    opponentImageView.image = image;
    homeImageView.image = homeImage;    
    
    return cell;
}

@end
