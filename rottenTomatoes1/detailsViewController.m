//
//  detailsViewController.m
//  rottenTomatoes1
//
//  Created by Rattan Priya on 9/16/14.
//  Copyright (c) 2014 Priya. All rights reserved.
//

#import "detailsViewController.h"

@interface detailsViewController ()

@end

@implementation detailsViewController
@synthesize detailsTitle,detailsDescription,detailsImage;
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
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *title = [defaults objectForKey:@"title"];
    NSString *synopsis = [defaults objectForKey:@"synopsis"];
    NSLog(@"title %@",title);
    NSLog(@"title %@",synopsis);
    
    
    [super viewDidLoad];
    self.detailsTitle.text = title;
    self.detailsDescription.text = synopsis;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
