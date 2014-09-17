//
//  MoviesViewController.m
//  rottenTomatoes1
//
//  Created by Rattan Priya on 9/12/14.
//  Copyright (c) 2014 Priya. All rights reserved.
//

#import "MoviesViewController.h"
#import "detailsViewController.h"
#import "MovieCell.h"
#import "UIImageView+AFNetworking.h"
#import "AMTumblrHud.h"
#import "errorView.h"
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface MoviesViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSArray *movies;

@end

@implementation MoviesViewController

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
    [self.tableView registerNib:[UINib nibWithNibName:@"EXCustomCell"
                                               bundle:[NSBundle mainBundle]]
         forCellReuseIdentifier:@"CustomCellReuseID"];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 125;
    
    [self.tableView registerNib:[UINib
                                 nibWithNibName:@"MovieCell" bundle:nil] forCellReuseIdentifier:@"MovieCell"];
    [self networkHandler];
    self.refreshControl = [[UIRefreshControl alloc]init];

//    refreshControl.attributedTitle = [[[NSAttributedString alloc]init] initWithString:@"Pull to refresh"];
    [self.refreshControl addTarget:self action:@selector(refreshView:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];

    //self.tableView = refresh;
//    self.title = @"Rotten Tomatoes";
    
   
    // Do any additional setup after loading the view from its nib.
}
- (void)scrollViewDidEndDecelerating:(UIScrollView*)scrollView
{
//    if( self.refresh.isRefreshing )
  //      [self refreshView:refresh()];
}

-(void) networkHandler
{
    NSString *url = @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=dagqdghwaq3e3mxyrp7kmmj5&limit=20&country=us";
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    
    /***SHOW PROGRESS BAR ***/
    AMTumblrHud *tumblrHUD = [[AMTumblrHud alloc] initWithFrame:CGRectMake((CGFloat) ((self.view.frame.size.width - 55) * 0.5),
                                                                           (CGFloat) ((self.view.frame.size.height - 20) * 0.5), 55,20)];
    tumblrHUD.hudColor = UIColorFromRGB(0xF1F2F3);
    [self.view addSubview:tumblrHUD];
    [tumblrHUD showAnimated:YES];
    /*====================*/
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:
     ^(NSURLResponse *response, NSData *data, NSError *error) {
         //Hide the loading view
         if ([data length] > 0 && error == nil)
         {
             [tumblrHUD setHidden:YES];
             NSDictionary *object = [NSJSONSerialization JSONObjectWithData:data options:nil error:nil];
             self.movies = object[@"movies"];
             [self.tableView reloadData];
         }
         
         else if ([data length] == 0 && error == nil)
         {
             [tumblrHUD setHidden:YES];
             NSLog(@"timestamped");
         }
         else if (error != nil)
         {
             //      [delegate timedOut];
             NSLog(@"Timeout happened %@",error);
             [tumblrHUD setHidden:YES];
             NSString *label = @"Hello";
             UILabel *err = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 20)];
             [err setTextColor:[UIColor blackColor]];
             [err setBackgroundColor:[UIColor clearColor]];
             [err setFont:[UIFont fontWithName: @"Trebuchet MS" size: 14.0f]];
             [self.tableView addSubview:err];
             err.text = @"Network Error";
             //Handle these cases
             //httpStatusCodes >= 400
             //timeout
             //ClientAbort
             
         }
         
         
     }];
}

-(void) refreshView : (UIRefreshControl *) refresh {
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Refreshing.."];
    [self networkHandler];
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM d,hh:mm a"];
    NSString *lastUpdated = [NSString stringWithFormat:@"Last Updated on %@",[formatter stringFromDate:[NSDate date]]];
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:lastUpdated];
    [refresh endRefreshing];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

-(NSInteger *) tableView:(UITableView *) tableView numberOfRowsInSection:(NSInteger)section {
    return self.movies.count;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *movie = self.movies[indexPath.row];
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    cell.titleLabel.text = movie[@"title"];
    cell.synopsisLabel.text = movie[@"synopsis"];
    NSString *posterUrl = [movie valueForKeyPath:@"posters.thumbnail"];
    [cell.posterView  setImageWithURL:[NSURL URLWithString:posterUrl]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
    //NSLog(@"tapped this one %ld",indexPath.row);
    [self.navigationController pushViewController:[[detailsViewController alloc] init] animated:YES];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *movie = self.movies[indexPath.row];
    NSString *title = movie[@"title"];
    NSString *synopsis = movie[@"synopsis"];
    [userDefaults setObject:title forKey:@"title"];
    [userDefaults setObject:synopsis forKey:@"synopsis"];
    //[userDefaults setObject:title forKey:@"title"];
    [userDefaults synchronize];
    
    
    
    
}
@end
