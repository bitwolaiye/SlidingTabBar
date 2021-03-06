//
//  RAPageCollectionView.m
//  RAPageViewController
//
//  Created by Evadne Wu on 12/25/12.
//  Copyright (c) 2012 Radius. All rights reserved.
//

#import "RAPageCollectionView.h"

@implementation RAPageCollectionView
@dynamic delegate;

- (void) setFrame:(CGRect)frame {

	CGRect fromFrame = self.frame;
	CGRect toFrame = frame;
		
	[self.pageViewDelegate pageCollectionView:self willChangeFromFrame:fromFrame toFrame:toFrame];
	
	[super setFrame:frame];

	[self.pageViewDelegate pageCollectionView:self didChangeFromFrame:fromFrame toFrame:toFrame];
	
}

- (void) layoutSubviews {

	[self.pageViewDelegate pageCollectionViewWillLayout:self];
	
	[super layoutSubviews];
	
	[self.pageViewDelegate pageCollectionViewDidLayout:self];

}

@end
