//
//  SecondViewController.m
//  SlidingTabBar
//
//  Created by ZhouQi on 13-2-26.
//  Copyright (c) 2013年 None. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)toDetail:(id)sender {
    UIViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"1d"];
    [self.parentViewController.parentViewController.navigationController pushViewController:controller animated:YES];
}
@end
