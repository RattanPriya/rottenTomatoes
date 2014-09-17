//
//  errorView.m
//  rottenTomatoes1
//
//  Created by Rattan Priya on 9/16/14.
//  Copyright (c) 2014 Priya. All rights reserved.
//

#import "errorView.h"

@implementation errorView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
  
    return self;
}
-(void) showAnimated:(BOOL)animated {
    if(animated) {
        NSLog(@"Calling SHowing Animation");
    }
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
