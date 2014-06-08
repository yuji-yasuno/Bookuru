//
//  CenterViewController.h
//  Bookuru
//
//  Created by 楊野勇智 on 2014/06/07.
//  Copyright (c) 2014年 salesforce.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <GoogleMaps/GoogleMaps.h>
#import "AFNetworking.h"
#import "JASidePanelController.h"
#import "UIViewController+JASidePanel.h"
#import "SideListViewController.h"
#import "AHKActionSheet.h"
#import "BookuruViewController.h"

@interface CenterViewController : UIViewController <CLLocationManagerDelegate,GMSMapViewDelegate>

typedef NS_ENUM(NSInteger, MapMode) {
    kMpNone = 0,
    kMpLibrary = 1,
    kMpCafe = 2,
    kMpBookuru = 3
};

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (weak, nonatomic) IBOutlet UIView *mapContainerView;
@property (strong, nonatomic) GMSMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *currentLocation;
@property (strong, nonatomic) NSString *currentAddress;
@property (strong, nonatomic) NSMutableArray *markers;
@property (strong, nonatomic) NSArray *libraries;
@property (strong, nonatomic) NSArray *cafes;
@property (strong, nonatomic) NSArray *bookurus;
- (void)searchLibrary;
- (void)searchCafe;
- (void)searchBookuru;
- (IBAction)askBookuru:(id)sender;
- (void)refresh;

@end
