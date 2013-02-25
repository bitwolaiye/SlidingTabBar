//
//  FirstDetailViewController.h
//  SlidingTabBar
//
//  Created by ZhouQi on 13-2-25.
//  Copyright (c) 2013年 None. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ViewControllerDelegate <NSObject>

-(void) viewControllerHasCanceled:(UIViewController *) controller;

@end

@interface FirstDetailViewController : UIViewController
- (IBAction)cancel:(id)sender;
@property (nonatomic, weak) id<ViewControllerDelegate> delegate;
@end
