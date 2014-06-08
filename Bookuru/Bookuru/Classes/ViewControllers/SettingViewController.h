//
//  SettingViewController.h
//  Bookuru
//
//  Created by 楊野勇智 on 2014/06/07.
//  Copyright (c) 2014年 salesforce.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingViewController : UITableViewController


@property (weak, nonatomic) IBOutlet UITableViewCell *searchRange300;
@property (weak, nonatomic) IBOutlet UITableViewCell *searchRange500;
@property (weak, nonatomic) IBOutlet UITableViewCell *searchRange1000;
@property (weak, nonatomic) IBOutlet UITableViewCell *searchRange2000;
@property (weak, nonatomic) IBOutlet UITableViewCell *searchRange5000;
@property (weak, nonatomic) IBOutlet UITableViewCell *wifiYes;
@property (weak, nonatomic) IBOutlet UITableViewCell *wifiNo;

- (IBAction)update:(id)sender;
- (IBAction)cancel:(id)sender;

@end
