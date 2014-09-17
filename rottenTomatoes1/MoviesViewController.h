//
//  MoviesViewController.h
//  rottenTomatoes1
//
//  Created by Rattan Priya on 9/12/14.
//  Copyright (c) 2014 Priya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoviesViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *networkError;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;
@property UIRefreshControl *refreshControl;
-(void) refreshView : (UIRefreshControl *) refresh;
-(void) networkHandler;

@end
