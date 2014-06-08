//
//  SideMenuViewController.m
//  Bookuru
//
//  Created by 楊野勇智 on 2014/06/07.
//  Copyright (c) 2014年 salesforce.com. All rights reserved.
//

#import "SideMenuViewController.h"

@interface SideMenuViewController ()

@end

@implementation SideMenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor colorWithRed:51 green:51 blue:51 alpha:0.2];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JASidePanelController *sideVc = [self sidePanelController];
    UINavigationController *centerNavi = (UINavigationController*)sideVc.centerPanel;
    CenterViewController *center = (CenterViewController*)centerNavi.viewControllers[0];
    
    switch (indexPath.row) {
        case 0:
        {
            [center searchLibrary];
            [sideVc showCenterPanelAnimated:YES];
            break;
        }
        case 1:
        {
            [center searchCafe];
            [sideVc showCenterPanelAnimated:YES];
            break;
        }
        case 2:
        {
            [center searchBookuru];
            [sideVc showCenterPanelAnimated:YES];
            break;
        }
        case 3:
        {
            UIViewController *next = [self.storyboard instantiateViewControllerWithIdentifier:@"setting"];
            [self presentViewController:next animated:YES completion:nil];
            break;
        }
        default:
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"確認" message:@"ログアウトしますか？" delegate:self cancelButtonTitle:@"いいえ" otherButtonTitles:@"はい", nil];
            [alert show];
            break;
        }
    }
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if ([title compare:@"はい"] == NSOrderedSame) {
        [[SFAuthenticationManager sharedManager] logout];
    }
}

@end
