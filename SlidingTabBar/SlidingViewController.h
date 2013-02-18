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
}

@property (nonatomic, strong) UIScrollView *slidingScrollView;
@property (nonatomic, weak) id<SlidingViewDelegate> slidingViewDelegate;

@property (nonatomic, strong) NSMutableArray *otherViewScreenshotImageViewArray;
@property int tabbarIndex;
@property int tabbarCount;

@end