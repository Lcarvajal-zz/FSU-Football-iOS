//
//  NewsTableViewController.m
//  FSU-Football
//
//  Created by Lukas Carvajal on 7/4/15.
//  Copyright (c) 2015 Lukas Carvajal. All rights reserved.
//

#import "NewsTableViewController.h"
#import "ArticleViewController.h"
#import "FSUArticle.h"

@interface NewsTableViewController ()

@property NSString* articleURL;

@end

@implementation NewsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // remove extra separators from tableview
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    
    if (!_articles) {
        _articles = [[NSMutableArray alloc] init];
    }
    
    if (!_articleURL) {
        _articleURL = [[NSString alloc] init];
    }
    
    [self loadNYTArticles];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// CUSTOM CLASSES

- (void) loadNYTArticles {
    
    // Set up link, search for Florida State Football articles in 2015.
    NSURL * url = [[NSURL alloc] initWithString:@"http://api.nytimes.com/svc/search/v2/articlesearch.json?q=florida+state+university+football+tallahassee&sort=newest&api-key=d3475bf8e7f2efe43b78fc097fb05325:1:72428141"];
    
    // Prepare request object.
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url
                                          cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                            timeoutInterval:30];
    // Prepare data for JSON response.
    NSData *urlData;
    NSURLResponse *response;
    NSError *error;
    
    // Make synchronous request.
    urlData = [NSURLConnection sendSynchronousRequest:urlRequest
                                    returningResponse:&response
                                                error:&error];
    
    // Construct an Array around the Data from response.
     NSDictionary *dict = [NSJSONSerialization
                        JSONObjectWithData:urlData
                        options:0
                        error:&error];
    NSArray *objects = [[dict objectForKey:@"response"] objectForKey:@"docs"];
    
    // Check if objects received.
    if ([objects count] > 0) {
        
        // Add create FSUArticle object and add to array.
        for (int i = 0; i < [objects count]; i++) {
        
            // Create article.
            FSUArticle* nytArticle = [[FSUArticle alloc] init];
            nytArticle.title = [[objects[i] objectForKey:@"headline"]valueForKey:@"main"];
            
            // Set article thumbnail.
            NSArray* articleImages = [[NSArray alloc]
                                      initWithArray:[[objects[i] objectForKey:@"multimedia"]valueForKey:@"url"]];
            if ([articleImages count] > 0) {
                
                nytArticle.thumbnail = [@"http://static01.nyt.com/" stringByAppendingString: [articleImages objectAtIndex:0]];
                
                for (int i = 0; i < [articleImages count]; i++) {
                    
                    NSString *checkForThumbnail = articleImages[i];
                    if ([checkForThumbnail rangeOfString:@"-thumbStandard"].location == NSNotFound) {
                    }
                    else {
                        nytArticle.thumbnail = [@"http://static01.nyt.com/" stringByAppendingString: [articleImages objectAtIndex:i]];
                    }
                }
                
                if ([nytArticle.thumbnail length] == 0)
                    nytArticle.thumbnail = @"no image";
            }
            else
                nytArticle.thumbnail = @"https://upload.wikimedia.org/wikipedia/commons/thumb/1/1c/FSU_text_logo.svg/939px-FSU_text_logo.svg.png";
            
            // Article date which is manipulated to look better.
            nytArticle.date = [objects[i] valueForKey:@"pub_date"];
            NSArray *array = [nytArticle.date componentsSeparatedByString:@"T"];
            if ([array count] > 0)
                array = [array[0] componentsSeparatedByString:@"-"];
            if ( [array count] == 3 ) {
                nytArticle.date = array[1];
                nytArticle.date = [nytArticle.date stringByAppendingString:@"-"];
                nytArticle.date = [nytArticle.date stringByAppendingString:array[2]];
                nytArticle.date = [nytArticle.date stringByAppendingString:@"-"];
                nytArticle.date = [nytArticle.date stringByAppendingString:array[0]];
            }
            
            // Article url changed to mobile version.
            nytArticle.url = [objects[i] valueForKey:@"web_url"];
            nytArticle.url = [nytArticle.url stringByReplacingOccurrencesOfString:@"www" withString:@"m"];
            
            nytArticle.snippet = [objects[i]valueForKey:@"snippet"];
        
            // Add to articles array.
            [self.articles addObject:nytArticle];
        }
    }
}

// END OF CUSTOM CLASSES

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return [self.articles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Background for cell.
    UIImage *background = [UIImage imageNamed:@"shadow-box"];
    UIImageView *cellBackgroundView = [[UIImageView alloc] initWithImage:background];
    cellBackgroundView.image = background;
    cell.backgroundView = cellBackgroundView;
    
    // Display article in the table cell.
    FSUArticle *nytArticle = [self.articles objectAtIndex:indexPath.row];
    
    UIImageView *articleImageView = (UIImageView *)[cell viewWithTag:103];
    if ([nytArticle.thumbnail isEqualToString:@"no image"])
         articleImageView.image = [UIImage imageNamed:@"news-tab"]; // no thumbnail available for article, set default
    else {
        articleImageView.image = [UIImage
                                  imageWithData:[NSData
                                                 dataWithContentsOfURL:[NSURL URLWithString:nytArticle.thumbnail]]];;
    }
    
    UILabel *articleNameLabel = (UILabel *)[cell viewWithTag:101];
    articleNameLabel.text = nytArticle.title;
    
    UILabel *articleDateLabel = (UILabel *)[cell viewWithTag:102];
    articleDateLabel.text = nytArticle.date;
    
    UILabel *articleSnippetLabel = (UILabel *)[cell viewWithTag:104];
    articleSnippetLabel.text = nytArticle.snippet;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // set article url for article to be viewed
    FSUArticle* fsuArticle = [self.articles objectAtIndex:indexPath.row];
    self.articleURL = fsuArticle.url;
    
    // remove cell selection
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self performSegueWithIdentifier:@"viewNewsSegue" sender:self];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"viewNewsSegue"]) {
        
        // Get destination view and set article url to be viewed
        ArticleViewController *vc = [segue destinationViewController];
        vc.articleURL = self.articleURL;
    }
}

@end
