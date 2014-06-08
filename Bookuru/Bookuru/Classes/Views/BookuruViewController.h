//
//  BookuruViewController.h
//  Bookuru
//
//  Created by 楊野勇智 on 2014/06/08.
//  Copyright (c) 2014年 salesforce.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>


@interface BookuruViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UITextField *titleContent;
@property (weak, nonatomic) IBOutlet UITextView *note;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (strong, nonatomic) CLLocation *location;
@property (strong, nonatomic) NSString *currentAddress;

- (IBAction)bookuru:(id)sender;
- (IBAction)cancel:(id)sender;


@end
