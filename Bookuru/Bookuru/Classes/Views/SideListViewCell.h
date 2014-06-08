//
//  SideListViewCell.h
//  Bookuru
//
//  Created by 楊野勇智 on 2014/06/08.
//  Copyright (c) 2014年 salesforce.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "SideListViewController.h"

@class SideListViewController;
@interface SideListViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) NSDictionary *item;
@property (strong, nonatomic) SideListViewController *parentTable;

- (IBAction)walk:(id)sender;

@end
