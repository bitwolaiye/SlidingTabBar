//
//  FirstViewController.h
//  SlidingTabBar
//
//  Created by ZhouQi on 13-2-18.
//  Copyright (c) 2013年 None. All rights reserved.
//

#import "SlidingViewController.h"
#import "FirstDetailViewController.h"
@interface FirstViewController : SlidingViewController<UITableViewDataSource, UITableViewDelegate, ViewControllerDelegate>
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@end
