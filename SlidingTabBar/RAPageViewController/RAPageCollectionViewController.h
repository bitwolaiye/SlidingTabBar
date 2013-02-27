//
//  RAPageCollectionViewController.h
//  RAPageViewController
//
//  Created by Evadne Wu on 12/24/12.
//  Copyright (c) 2012 Radius. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RAPageCollectionViewControllerDelegate.h"
#import "PSTCollectionView.h"

@interface RAPageCollectionViewController : UIViewController <PSUICollectionViewDataSource, PSUICollectionViewDelegate, PSUICollectionViewDelegateFlowLayout>

@property (nonatomic, readwrite, weak) id<RAPageCollectionViewControllerDelegate> delegate;

@property (nonatomic, readonly, strong) PSTCollectionView *collectionView;
@property (nonatomic, readonly, strong) PSTCollectionViewFlowLayout *collectionViewLayout;

@property (nonatomic, readwrite, assign) CGFloat displayIndex;	//	if no pages, it’ll be NAN, use isnan()
- (void) setDisplayIndex:(CGFloat)displayIndex animated:(BOOL)animate completion:(void(^)(void))completionBlock;

+ (Class) collectionViewCellClass;
+ (NSString *) collectionViewCellReuseIdentifier;

@end
