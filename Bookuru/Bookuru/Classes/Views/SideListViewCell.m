//
//  SideListViewCell.m
//  Bookuru
//
//  Created by 楊野勇智 on 2014/06/08.
//  Copyright (c) 2014年 salesforce.com. All rights reserved.
//

#import "SideListViewCell.h"

@implementation SideListViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)walk:(id)sender {
    
    CLLocation *daddr = self.item[@"daddr"] != [NSNull null] ? self.item[@"daddr"] : nil;
    CLLocation *saddr = self.item[@"saddr"] != [NSNull null] ? self.item[@"saddr"] : nil;
    if (daddr == nil || saddr == nil) return;
    
    NSMutableString *path = [[NSMutableString alloc] init];
    [path appendString:@"comgooglemaps://"];
    [path appendFormat:@"?daddr=%f,%f",daddr.coordinate.latitude, daddr.coordinate.longitude];
    [path appendFormat:@"&saddr=%f,%f",saddr.coordinate.latitude, saddr.coordinate.longitude];
    
    NSURL *url = [NSURL URLWithString:path];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        }
    });
    [self.parentTable backToCenter];
}

@end
