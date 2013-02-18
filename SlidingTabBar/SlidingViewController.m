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
        initScrollView = NO;
        self.tabbarCount = 1;
        self.tabbarIndex = 0;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Custom initialization
        initScrollView = NO;
        self.tabbarCount = 1;
        self.tabbarIndex = 0;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    scrollViewDelegate = [[SlidingScrollViewDelegate alloc] init];
    [scrollViewDelegate setPage:self.tabbarIndex];
    scrollViewDelegate.delegate = self;
    self.scrollView.delegate = scrollViewDelegate;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    
    self.imageViewArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < self.tabbarCount; i++) {
        if (i != self.tabbarIndex) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width * i, 0, self.view.frame.size.width, self.view.frame.size.height - 49)];
            [self.scrollView addSubview:imageView];
            [self.imageViewArray addObject:imageView];
        }
    }
}

- (void)viewDidAppear:(BOOL)animated{
    float width = self.scrollView.frame.size.width;
    float height = self.scrollView.frame.size.height;
    
    self.scrollView.contentSize = CGSizeMake(width * self.tabbarCount, height);
    if (!initScrollView) {
        for (UIView *view in self.scrollView.subviews) {
            if (![self.imageViewArray containsObject:view]) {
                view.frame = CGRectMake(view.frame.origin.x + width * self.tabbarIndex, view.frame.origin.y, view.frame.size.width, view.frame.size.height);
            }
        }
        initScrollView = YES;
    }
    [self resetScrollPosition];
}

- (void)viewWillDisappear:(BOOL)animated{
    [self resetScrollPosition];
    for (UIImageView *imageView in self.imageViewArray) {
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
    UIGraphicsBeginImageContextWithOptions(self.scrollView.frame.size, NO, 0.0);
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
        UIImageView *imageView = [self.imageViewArray objectAtIndex:i];
        imageView.image = [imageArray objectAtIndex:i];
    }
}

- (void) resetScrollPosition;{
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height - 49;
    [self.scrollView scrollRectToVisible:CGRectMake(width * self.tabbarIndex, 0, width, height) animated:NO];
}
@end