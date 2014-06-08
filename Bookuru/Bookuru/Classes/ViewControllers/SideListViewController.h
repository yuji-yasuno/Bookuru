//
//  SideListViewController.h
//  Bookuru
//
//  Created by 楊野勇智 on 2014/06/08.
//  Copyright (c) 2014年 salesforce.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JASidePanelController.h"
#import "UIViewController+JASidePanel.h"
#import "SideListViewCell.h"

@interface SideListViewController : UITableViewController

@property (strong, nonatomic) NSArray *items;
- (void)updateItems:(NSArray*)newItems;
- (void)backToCenter;

@end
