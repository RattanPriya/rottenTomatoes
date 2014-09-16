//
//  MovieCell.h
//  rottenTomatoes1
//
//  Created by Rattan Priya on 9/15/14.
//  Copyright (c) 2014 Priya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieCell : UITableViewCell
@property (weak , nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;
@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@end
