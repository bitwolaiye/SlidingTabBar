//
//  SlidingTabBarController.m
//  SlidingTabBar
//
//  Created by ZhouQi on 13-2-18.
//  Copyright (c) 2013年 None. All rights reserved.
//

#import "SlidingTabBarController.h"

@interface SlidingTabBarController ()

@end

@implementation SlidingTabBarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.delegate = self;
    int index = 0;
    for (SlidingViewController *controller in self.viewControllers) {
        controller.delegate = self;
        controller.tabbarCount = [self.viewControllers count];
        controller.tabbarIndex = index++;
    }
    for (UIView *view in self.view.subviews) {
        if ([view class] == [UITabBar class]) {
            view.frame = CGRectMake(view.frame.origin.x, 20, view.frame.size.width, view.frame.size.height);
        }else{
            view.frame = CGRectMake(view.frame.origin.x, 49, view.frame.size.width, 480 - 49);
        }
    }
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tabbar delegate

- (void)setOtherViewImage:(int)index {
    NSMutableArray *imageArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < [self.viewControllers count]; i++) {
        if (i != index) {
            id<SlidingTabBarItemInterface> tabBarItem = [self.viewControllers objectAtIndex:i];
            UIImage *image = [tabBarItem screenshot];
            if (image != nil) {
                [imageArray addObject:image];
            }
        }
    }
    id<SlidingTabBarItemInterface> thisTabBarItem = [self.viewControllers objectAtIndex:index];
    [thisTabBarItem setImages:imageArray];
}

- (BOOL) tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    int start = [self.viewControllers indexOfObject:tabBarController.selectedViewController];
    int end = [self.viewControllers indexOfObject:viewController];
    if (start == end) {
        return NO;
    }
    BOOL forward = start < end;
    NSLog(@"%d %d", start, end);
    
    NSMutableArray *imageViewArray = [[NSMutableArray alloc] init];
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height - 49 - 20;
    NSLog(@"%.f", height);
    for (int i = 0; i <= fabs(start - end); i++) {
        id<SlidingTabBarItemInterface> tabBarItem = [self.viewControllers objectAtIndex:start + i * (forward ? 1: -1)];
        NSLog(@"index:%d", start + i * (forward ? 1: -1));
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [tabBarItem screenshot];
        imageView.frame = CGRectMake(width * i * (forward ? 1: -1), 49 + 20, width, height);
        [self.view addSubview:imageView];
        [self.view bringSubviewToFront:imageView];
        [imageViewArray addObject:imageView];
    }
    [self setOtherViewImage:end];
    
    [UIView animateWithDuration:0.3 animations:^{
        for (UIImageView *imageView in imageViewArray) {
            imageView.frame = CGRectMake(imageView.frame.origin.x - width  * (end - start), imageView.frame.origin.y, imageView.frame.size.width, imageView.frame.size.height);
        }
    } completion:^(BOOL finished) {
        for (UIImageView *imageView in imageViewArray) {
            imageView.image = nil;
            [imageView removeFromSuperview];
        }
        [imageViewArray removeAllObjects];
        id<SlidingTabBarItemInterface> tabBarItem = [self.viewControllers objectAtIndex:start];
        [tabBarItem resetScrollPosition];
    }];
    return YES;
}

-(void)slidingView:(SlidingViewController *) viewController toPage:(int) page;{
    [self setSelectedIndex:page];
    [viewController resetScrollPosition];
    [self setOtherViewImage:page];
}


@end
