//
//  RootViewController.h
//  SlidingTabBar
//
//  Created by ZhouQi on 13-2-26.
//  Copyright (c) 2013年 None. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionViewController.h"
@interface RootViewController : UIViewController <UIPageViewControllerDelegate, UIPageViewControllerDataSource, UITabBarDelegate, PagerDelegate, RAPageCollectionViewControllerDelegate>{
    int cnt;
    BOOL isSelectAnimation;
}

@property (strong, nonatomic) CollectionViewController *pageViewController;
@property (strong, nonatomic) IBOutlet UITabBar *tabBar;
@property (nonatomic, strong) NSMutableDictionary *dict;
@end
