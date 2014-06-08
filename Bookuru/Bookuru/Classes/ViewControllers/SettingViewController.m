//
//  SettingViewController.m
//  Bookuru
//
//  Created by 楊野勇智 on 2014/06/07.
//  Copyright (c) 2014年 salesforce.com. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor colorWithRed:51 green:51 blue:51 alpha:0.2];
    [self checkUserDefaults];
    [self checkCurrentSettings];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            [self uncheckAllRange];
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            break;
        }
        case 1:
        {
            [self uncheckAllWifi];
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            break;
        }
        default:
            break;
    }
}

#pragma mark - My custom methods
- (void)checkUserDefaults
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults integerForKey:@"search_range"] == 0) {
        [defaults setInteger:300 forKey:@"search_range"];
    }
}

- (void)checkCurrentSettings
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [self uncheckAllRange];
    int range = [defaults integerForKey:@"search_range"];
    switch (range) {
        case 300:
        {
            self.searchRange300.accessoryType = UITableViewCellAccessoryCheckmark;
            break;
        }
        case 500:
        {
            self.searchRange500.accessoryType = UITableViewCellAccessoryCheckmark;
            break;
        }
        case 1000:
        {
            self.searchRange1000.accessoryType = UITableViewCellAccessoryCheckmark;
            break;
        }
        case 2000:
        {
            self.searchRange2000.accessoryType = UITableViewCellAccessoryCheckmark;
            break;
        }
        case 5000:
        {
            self.searchRange5000.accessoryType = UITableViewCellAccessoryCheckmark;
            break;
        }
        default:
            break;
    }
    
    [self uncheckAllWifi];
    if ([defaults boolForKey:@"search_with_wifi"] == YES) {
        self.wifiYes.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else {
        self.wifiNo.accessoryType = UITableViewCellAccessoryCheckmark;
    }
}

- (void)uncheckAllRange
{
    self.searchRange300.accessoryType = UITableViewCellAccessoryNone;
    self.searchRange500.accessoryType = UITableViewCellAccessoryNone;
    self.searchRange1000.accessoryType = UITableViewCellAccessoryNone;
    self.searchRange2000.accessoryType = UITableViewCellAccessoryNone;
    self.searchRange5000.accessoryType = UITableViewCellAccessoryNone;
}

- (void)uncheckAllWifi
{
    self.wifiYes.accessoryType = UITableViewCellAccessoryNone;
    self.wifiNo.accessoryType = UITableViewCellAccessoryNone;
}


#pragma mark - Custom events
- (IBAction)update:(id)sender {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (self.searchRange300.accessoryType == UITableViewCellAccessoryCheckmark) {
        [defaults setInteger:300 forKey:@"search_range"];
    }
    else if (self.searchRange500.accessoryType == UITableViewCellAccessoryCheckmark) {
        [defaults setInteger:500 forKey:@"search_range"];
    }
    else if (self.searchRange1000.accessoryType == UITableViewCellAccessoryCheckmark) {
        [defaults setInteger:1000 forKey:@"search_range"];
    }
    else if (self.searchRange2000.accessoryType == UITableViewCellAccessoryCheckmark) {
        [defaults setInteger:2000 forKey:@"search_range"];
    }
    else if (self.searchRange5000.accessoryType == UITableViewCellAccessoryCheckmark) {
        [defaults setInteger:5000 forKey:@"search_range"];
    }
    
    if (self.wifiYes.accessoryType == UITableViewCellAccessoryCheckmark) {
        [defaults setBool:YES forKey:@"search_with_wifi"];
    }
    else if (self.wifiNo.accessoryType == UITableViewCellAccessoryCheckmark) {
        [defaults setBool:NO forKey:@"search_with_wifi"];
    }
    [defaults synchronize];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancel:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
