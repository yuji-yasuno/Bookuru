//
//  BookuruViewController.m
//  Bookuru
//
//  Created by 楊野勇智 on 2014/06/08.
//  Copyright (c) 2014年 salesforce.com. All rights reserved.
//

#import "BookuruViewController.h"

@interface BookuruViewController ()

@end

@implementation BookuruViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.address.text = self.currentAddress;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view endEditing:YES];
}

#pragma mark - My custom methods
- (void)createBookuru
{
    NSMutableArray *fields = [[NSMutableArray alloc] init];
    [fields addObject:@"address__c"];
    [fields addObject:@"LatLng__Latitude__s"];
    [fields addObject:@"LatLng__Longitude__s"];
    [fields addObject:@"Title__c"];
    [fields addObject:@"Note__c"];
    
    NSMutableArray *values = [[NSMutableArray alloc] init];
    [values addObject:[[NSString alloc] initWithFormat:@"%@", [self.address text]]];
    [values addObject:[[NSString alloc] initWithFormat:@"%f", self.location.coordinate.latitude]];
    [values addObject:[[NSString alloc] initWithFormat:@"%f", self.location.coordinate.longitude]];
    [values addObject:[[NSString alloc] initWithFormat:@"%@", [self.titleContent text]]];
    [values addObject:[[NSString alloc] initWithFormat:@"%@", [self.note text]]];
    
    NSDictionary *data = [[NSDictionary alloc] initWithObjects:values forKeys:fields];
    SFRestAPI *api = [SFRestAPI sharedInstance];
    SFRestRequest *request = [api requestForCreateWithObjectType:@"Bookuru__c" fields:data];
    [api sendRESTRequest:request
               failBlock:^(NSError *error)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.indicator stopAnimating];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"エラー" message:error.localizedDescription delegate:nil cancelButtonTitle:@"はい" otherButtonTitles:nil, nil];
            [alert show];
        });
    }
           completeBlock:^(id jsonResponse)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.indicator stopAnimating];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"情報" message:@"保存されました。" delegate:nil cancelButtonTitle:@"はい" otherButtonTitles:nil, nil];
            [alert show];
            [self dismissViewControllerAnimated:YES completion:nil];
        });
    }];
    [self.indicator startAnimating];
}

- (IBAction)bookuru:(id)sender {
    [self createBookuru];
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
