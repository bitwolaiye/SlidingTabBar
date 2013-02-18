//
//  SlidingTabBarItemInterface.h
//  SlidingTabBar
//
//  Created by ZhouQi on 13-2-18.
//  Copyright (c) 2013年 None. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SlidingTabBarItemInterface <NSObject>
-(UIImage *)screenshot;
-(void)setImages:(NSArray *) imageArray;
-(void)resetScrollPosition;
@end
