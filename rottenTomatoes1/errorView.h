//
//  errorView.h
//  rottenTomatoes1
//
//  Created by Rattan Priya on 9/16/14.
//  Copyright (c) 2014 Priya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface errorView : UIView
@property (nonatomic, strong) UIColor *bgColor;
@property (nonatomic,weak) UILabel *errorDisplay;

@property (nonatomic, strong) UIColor *hudColor;


-(void)showAnimated:(BOOL)animated;
-(void)hide;


@end
