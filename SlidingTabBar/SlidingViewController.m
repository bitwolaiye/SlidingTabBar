//
//  SlidingViewController.m
//  SlidingTabBar
//
//  Created by ZhouQi on 13-2-18.
//  Copyright (c) 2013年 None. All rights reserved.
//

#import "SlidingViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation SlidingScrollViewDelegate
- (id)init{
    if (!(self = [super init]))
    {
		return nil;
    }
    self.page = 0;
    return self;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat pageWidth = scrollView.frame.size.width;
    if (self.page != floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1) {
        [self.delegate slidingView:nil toPage:floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1];
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    
}

@end

@interface SlidingViewController ()

@end

@implementation SlidingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tabbarCount = 1;
        self.tabbarIndex = 0;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Custom initialization
        self.tabbarCount = 1;
        self.tabbarIndex = 0;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.slidingScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 49)];
    scrollViewDelegate = [[SlidingScrollViewDelegate alloc] init];
    [scrollViewDelegate setPage:self.tabbarIndex];
    scrollViewDelegate.delegate = self;
    self.slidingScrollView.delegate = scrollViewDelegate;
    self.slidingScrollView.pagingEnabled = YES;
    self.slidingScrollView.showsHorizontalScrollIndicator = NO;
    self.slidingScrollView.showsVerticalScrollIndicator = NO;
    self.slidingScrollView.alwaysBounceHorizontal = YES;
    self.slidingScrollView.alwaysBounceVertical = NO;
    
    self.otherViewScreenshotImageViewArray = [[NSMutableArray alloc] init];
    
    for (UIView *view in self.view.subviews) {
        [view removeFromSuperview];
        view.frame = CGRectMake(view.frame.origin.x + self.slidingScrollView.frame.size.width * self.tabbarIndex, view.frame.origin.y, view.frame.size.width, view.frame.size.height);
        [self.slidingScrollView addSubview:view];
    }
    [self.view addSubview:self.slidingScrollView];
    
    for (int i = 0; i < self.tabbarCount; i++) {
        if (i != self.tabbarIndex) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width * i, 0, self.view.frame.size.width, self.view.frame.size.height - 49)];
            [self.slidingScrollView addSubview:imageView];
            [self.otherViewScreenshotImageViewArray addObject:imageView];
        }
    }
}

- (void)viewDidAppear:(BOOL)animated{
    float width = self.slidingScrollView.frame.size.width;
    float height = self.slidingScrollView.frame.size.height;
    
    self.slidingScrollView.contentSize = CGSizeMake(width * self.tabbarCount, height);
    [self resetScrollPosition];
}

- (void)viewWillDisappear:(BOOL)animated{
    [self resetScrollPosition];
    for (UIImageView *imageView in self.otherViewScreenshotImageViewArray) {
        imageView.image = nil;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIImage *)screenshot
{
    UIGraphicsBeginImageContextWithOptions(self.slidingScrollView.frame.size, NO, 0.0);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenshot;
}

#pragma mark - tab bar delegate
-(void)slidingView:(SlidingViewController *) viewController toPage:(int) page;{
    [self.slidingViewDelegate slidingView:self toPage:page];
}

- (void) setImages:(NSArray *) imageArray;{
    for (int i = 0; i < [imageArray count]; i++) {
        UIImageView *imageView = [self.otherViewScreenshotImageViewArray objectAtIndex:i];
        imageView.image = [imageArray objectAtIndex:i];
    }
}

- (void) resetScrollPosition;{
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height - 49;
    [self.slidingScrollView scrollRectToVisible:CGRectMake(width * self.tabbarIndex, 0, width, height) animated:NO];
}
@end