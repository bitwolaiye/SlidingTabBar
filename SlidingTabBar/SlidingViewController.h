//
//  SlidingViewController.h
//  SlidingTabBar
//
//  Created by ZhouQi on 13-2-18.
//  Copyright (c) 2013年 None. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlidingTabBarItemInterface.h"

@class SlidingViewController;

@protocol SlidingViewDelegate <NSObject>
-(void)slidingView:(SlidingViewController *) viewController toPage:(int) page;
@end

@interface SlidingScrollViewDelegate : NSObject<UIScrollViewDelegate>
@property (nonatomic, weak) id<SlidingViewDelegate> delegate;
@property int page;
@end

@interface SlidingViewController : UIViewController<SlidingViewDelegate, SlidingTabBarItemInterface, UIScrollViewDelegate>{
    SlidingScrollViewDelegate *scrollViewDelegate;
    BOOL initScrollView;
}

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, weak) id<SlidingViewDelegate> delegate;

@property (nonatomic, strong) NSMutableArray *imageVewArray;
@property int tabbarIndex;
@property int tabbarCount;

@end