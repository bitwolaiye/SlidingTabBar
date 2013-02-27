//
//  CollectionViewController.m
//  SlidingTabBar
//
//  Created by ZhouQi on 13-2-27.
//  Copyright (c) 2013年 None. All rights reserved.
//

#import "CollectionViewController.h"
#import "RAPageCollectionViewControllerDelegate.h"

@interface CollectionViewController ()<RAPageCollectionViewControllerDelegate>
@property (nonatomic, readonly, strong) NSMutableArray *viewControllers;
@end

@implementation CollectionViewController
@synthesize viewControllers = _viewControllers;

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (!self)
		return nil;
	isDrag = NO;
    page = 0;
	return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.collectionView.delegate = self;
    self.collectionView.clipsToBounds = NO;
	self.collectionView.showsHorizontalScrollIndicator = NO;
	self.collectionView.showsVerticalScrollIndicator = NO;
	self.collectionView.alwaysBounceHorizontal = YES;
	self.collectionView.alwaysBounceVertical = NO;
	self.collectionViewLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
	self.collectionViewLayout.minimumLineSpacing = 0.0f;
    self.collectionViewLayout.minimumInteritemSpacing = 0.0f;
    self.collectionViewLayout.headerReferenceSize = (CGSize){0.0f, 0.0f};
    self.collectionViewLayout.footerReferenceSize = (CGSize){0.0f, 0.0f};
    self.collectionViewLayout.itemSize = (CGSize){320.0f, 411.0f};
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (NSUInteger) numberOfViewControllersInPageCollectionViewController:(RAPageCollectionViewController *)pageCollectionViewController {
//    
//	return [self.viewControllers count];
//    
//}
//
//- (UIViewController *) viewControllerForPageAtIndex:(NSUInteger)index inPageCollectionViewController:(RAPageCollectionViewController *)pageCollectionViewController {
//	
//	return self.viewControllers[index];
//    
//}
//
//- (NSMutableArray *) viewControllers {
//    
//	if (!_viewControllers) {
//        
//		_viewControllers = [@[
//                            
//                            [self newContentViewController],
//                            [self newContentViewController],
//                            [self newContentViewController],
//                            [self newContentViewController],
//                            [self newContentViewController]
//                            
//                            ] mutableCopy];
//        
//	}
//	
//	return _viewControllers;
//    
//}
//
//- (void) viewWillAppear:(BOOL)animated {
//    
//	[super viewWillAppear:animated];
//	
////	[self.navigationController setToolbarHidden:NO animated:animated];
//    
//}
//
//- (UIViewController *) newContentViewController {
//    
//	UIViewController *pvcsPVC = [[UIViewController alloc] initWithNibName:nil bundle:nil];
//    pvcsPVC.view.backgroundColor = [UIColor redColor];
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
//    label.text = @"string";
//    [pvcsPVC.view addSubview:label];
//	return pvcsPVC;
//    
//}

#pragma mark - scroll delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;{
    isDrag = YES;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    isDrag = NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;{
    if (!isDrag) {
        int thisPage = floor((scrollView.contentOffset.x + scrollView.frame.size.width / 2) / scrollView.frame.size.width);
        if (page != thisPage) {
            [self.pagerDelegate willScrollFromPage:page ToPage:thisPage];
            page = thisPage;
            NSLog(@"scroll to %d", page);
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat pageWidth = scrollView.frame.size.width;
    NSLog(@"%d", (int)floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1);
    NSLog(@"%f %f", scrollView.contentSize.width, scrollView.contentSize.height);
    [self.pagerDelegate didScrollToPage:(int)floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1];
}
@end
