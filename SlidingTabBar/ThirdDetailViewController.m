//
//  ThirdDetailViewController.m
//  SlidingTabBar
//
//  Created by ZhouQi on 13-2-26.
//  Copyright (c) 2013年 None. All rights reserved.
//

#import "ThirdDetailViewController.h"

@interface ThirdDetailViewController ()

@end

@implementation ThirdDetailViewController

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
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated;{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
