//
//  CollectionViewController.h
//  SlidingTabBar
//
//  Created by ZhouQi on 13-2-27.
//  Copyright (c) 2013年 None. All rights reserved.
//

#import "RAPageCollectionViewController.h"
#import "RAPageCollectionViewDelegate.h"

@protocol PagerDelegate <NSObject>

- (void)willScrollFromPage:(int) fromPage ToPage:(int) toPage;
- (void)didScrollToPage:(int) page;

@end

@interface CollectionViewController : RAPageCollectionViewController<UIScrollViewDelegate>{
    BOOL isDrag;
    int page;
}
@property (nonatomic, weak) id<PagerDelegate> pagerDelegate;
@end
