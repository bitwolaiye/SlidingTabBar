//
//  RAPageCollectionView.h
//  RAPageViewController
//
//  Created by Evadne Wu on 12/25/12.
//  Copyright (c) 2012 Radius. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RAPageCollectionViewDelegate.h"
#import "PSTCollectionView.h"

@interface RAPageCollectionView : PSTCollectionView

@property (nonatomic, assign) id <RAPageCollectionViewDelegate> pageViewDelegate;

@end
