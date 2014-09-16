//
//  MoviesViewController.m
//  rottenTomatoes1
//
//  Created by Rattan Priya on 9/12/14.
//  Copyright (c) 2014 Priya. All rights reserved.
//

#import "MoviesViewController.h"
#import "MovieCell.h"
#import "UIImageView+AFNetworking.h"
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
    NSString *url = @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=dagqdghwaq3e3mxyrp7kmmj5&limit=20&country=us";
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:
^(NSURLResponse *response, NSData *data, NSError *connectionError) {
    //Hide the loading view
    if(!connectionError){
    NSDictionary *object = [NSJSONSerialization JSONObjectWithData:data options:nil error:nil];
    self.movies = object[@"movies"];
    NSLog(@"movies: %@", self.movies);
        [self.tableView reloadData];
    }
    else{
        //Display an error alert
    }
}];
    // Do any additional setup after loading the view from its nib.
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
    NSLog(@"index Path:%ld",indexPath.row);
    
    NSDictionary *movie = self.movies[indexPath.row];

    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    cell.titleLabel.text = movie[@"title"];
    cell.synopsisLabel.text = movie[@"synopsis"];
    NSString *posterUrl = [movie valueForKeyPath:@"posters.thumbnail"];
    [cell.posterView  setImageWithURL:[NSURL URLWithString:posterUrl]];
    //cell.posterView.image = movie[@"image"];
    //cell.titleLabel.text = movie[@"title"];
    //cell.textLabel.text = [NSString stringWithFormat:@"I'm at row: %ld",indexPath.row];
    return cell;
}
@end
