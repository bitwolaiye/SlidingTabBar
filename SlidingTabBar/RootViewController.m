//
//  RootViewController.m
//  SlidingTabBar
//
//  Created by ZhouQi on 13-2-26.
//  Copyright (c) 2013年 None. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()
@property (nonatomic, strong) NSMutableArray *viewControllers;
@end

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    cnt = 3;
    isSelectAnimation = NO;
    self.dict = [[NSMutableDictionary alloc] init];
	// Do any additional setup after loading the view, typically from a nib.
    // Configure the page view controller and add it as a child view controller.
    self.pageViewController = [[CollectionViewController alloc] initWithNibName:nil bundle:nil];
    self.pageViewController.pagerDelegate = self;
    self.pageViewController.delegate = self;
    self.tabBar.delegate = self;
    self.tabBar.selectedItem = [self.tabBar.items objectAtIndex:0];
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];

    CGRect pageViewRect = self.view.bounds;
    self.pageViewController.view.frame = CGRectMake(0, 49, pageViewRect.size.width, pageViewRect.size.height - 49);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated;{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (UIViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard
{
    // Return the data view controller for the given index.
    if (index >= cnt) {
        return nil;
    }
    // Create a new view controller and pass suitable data.
    UIViewController *controller = [storyboard instantiateViewControllerWithIdentifier:[NSString stringWithFormat:@"%d", index]];
    [self.dict setObject:controller forKey:[NSNumber numberWithInt:index]];
    return controller;
}

- (NSUInteger)indexOfViewController:(UIViewController *)viewController
{
    __block NSUInteger index = NSNotFound;
    [self.dict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if (obj == viewController) {
            index = [key integerValue];
        }
    }];
    return index;
}
#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(UIViewController *)viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(UIViewController *)viewController];
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == cnt) {
        return nil;
    }
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

#pragma mark - UIPageViewController delegate methods
- (UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    // Set the spine position to "min" and the page view controller's view controllers array to contain just one view controller. Setting the spine position to 'UIPageViewControllerSpineLocationMid' in landscape orientation sets the doubleSided property to YES, so set it to NO here.
    UIViewController *currentViewController = pageViewController.viewControllers[0];
    NSArray *viewControllers = @[currentViewController];
    [pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:NULL];
    
    pageViewController.doubleSided = NO;
    return UIPageViewControllerSpineLocationMin;
}


- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    int start = [[[self.dict allKeysForObject:[previousViewControllers objectAtIndex:0]] objectAtIndex:0] intValue];
    int end = [[[self.dict allKeysForObject:[pageViewController.viewControllers objectAtIndex:0]] objectAtIndex:0] intValue];
    NSLog(@"%d->%d", start, end);
    NSLog(@"%d", [self.pageViewController.childViewControllers count]);
    self.tabBar.selectedItem = [self.tabBar.items objectAtIndex:end];
}

#pragma mark - UITabBarDelegate
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item;{
    int end = [tabBar.items indexOfObject:item];
    isSelectAnimation = YES;
    [self.pageViewController setDisplayIndex:end animated:YES completion:^{
        isSelectAnimation = NO;
    }];
}

#pragma mark - pager delegate
- (void)willScrollFromPage:(int) fromPage ToPage:(int) toPage;{
    if (!isSelectAnimation) {
        self.tabBar.selectedItem = [self.tabBar.items objectAtIndex:toPage];
    }
}
- (void)didScrollToPage:(int) page;{
    
}

#pragma mark - collection delegate
- (NSUInteger) numberOfViewControllersInPageCollectionViewController:(RAPageCollectionViewController *)pageCollectionViewController {
	return cnt;
}

- (UIViewController *) viewControllerForPageAtIndex:(NSUInteger)index inPageCollectionViewController:(RAPageCollectionViewController *)pageCollectionViewController {
	return [self viewControllerAtIndex:index storyboard:self.storyboard];
}

#pragma mark - scroll delegate


- (void)viewDidUnload {
    [self setTabBar:nil];
    [self setViewControllers:nil];
    [super viewDidUnload];
}
@end
