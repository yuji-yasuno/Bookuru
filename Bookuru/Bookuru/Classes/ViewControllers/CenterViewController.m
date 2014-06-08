//
//  CenterViewController.m
//  Bookuru
//
//  Created by 楊野勇智 on 2014/06/07.
//  Copyright (c) 2014年 salesforce.com. All rights reserved.
//

#import "CenterViewController.h"

@interface CenterViewController ()
{
    BOOL isFirstLocation;
    MapMode _mpMode;
}

@end

@implementation CenterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _mpMode = kMpNone;
    
    isFirstLocation = YES;
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = 10;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.locationManager startUpdatingLocation];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.locationManager stopUpdatingLocation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    self.currentLocation = location;
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:self.currentLocation
                   completionHandler:^(NSArray* placemarks, NSError *error)
     {
         if (placemarks != nil && placemarks.count > 0) {
             CLPlacemark *placemark = [placemarks objectAtIndex:0];
             NSMutableString *address = [[NSMutableString alloc] init];
             
             NSString *zip = [placemark.addressDictionary objectForKey:@"ZIP"] != nil ? [[NSString alloc] initWithFormat:@"%@", [placemark.addressDictionary objectForKey:@"ZIP"]] : @"";
             NSString *county = [placemark.addressDictionary objectForKey:@"Country"] != nil ? [[NSString alloc] initWithFormat:@"%@", [placemark.addressDictionary objectForKey:@"Country"]] : @"";
             NSString *state = [placemark.addressDictionary objectForKey:@"State"] != nil ? [[NSString alloc] initWithFormat:@"%@", [placemark.addressDictionary objectForKey:@"State"]] : @"";
             NSString *city = [placemark.addressDictionary objectForKey:@"City"] != nil ? [[NSString alloc] initWithFormat:@"%@", [placemark.addressDictionary objectForKey:@"City"]] : @"";
             NSString *street = [placemark.addressDictionary objectForKey:@"Street"] != nil ? [[NSString alloc] initWithFormat:@"%@", [placemark.addressDictionary objectForKey:@"Street"]] : @"";
             [address appendFormat:@"%@ %@ %@ %@ %@", zip, county, state, city, street];
             self.currentAddress = address;
         }
         
     }];
    
    if (isFirstLocation) {
        
        [self createMapAtLat:location.coordinate.latitude Lng:location.coordinate.longitude withZoom:15];
        isFirstLocation = NO;
        [self searchLibrary];
    }
}

#pragma mark - GMSMapViewDelegate
- (void)mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker
{
    NSDictionary *record = nil;
    for (NSInteger ii = 0; ii < self.markers.count; ii++) {
        if (marker == self.markers[ii]) {

        }
    }
    if (record == nil) return;

    

}

#pragma mark - My custom methods
- (void)createMapAtLat:(double)latitude Lng:(double)longitude withZoom:(double)zoom
{
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:latitude longitude:longitude zoom:zoom bearing:0 viewingAngle:60];
    self.mapView = [GMSMapView mapWithFrame:self.mapContainerView.bounds camera:camera];
    self.mapView.delegate = self;
    self.mapView.mapType = kGMSTypeNormal;
    self.mapView.myLocationEnabled = YES;
    self.mapView.settings.compassButton = YES;
    self.mapView.settings.myLocationButton = YES;
    [self.mapContainerView addSubview:self.mapView];
}

- (void)setPinsOnMap
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if (self.markers != nil && self.markers.count > 0) {
            for (GMSMarker *marker in self.markers) {
                marker.map = nil;
            }
        }
        
        switch (_mpMode) {
            case kMpLibrary:
            {
                self.markers = [self craeteMarkersFromLibraris:self.libraries];
                break;
            }
            case kMpCafe:
            {
                self.markers = [self craeteMarkersFromCafes:self.cafes];
                break;
            }
            case kMpBookuru:
            {
                self.markers = [self craeteMarkersFromBookurus:self.bookurus];
                break;
            }
            default:
            {
                break;
            }
        }
        
        NSMutableArray *sideItems = [[NSMutableArray alloc] init];
        for (GMSMarker *marker in self.markers) {
            
            marker.map = self.mapView;
            
            NSMutableDictionary *item = [[NSMutableDictionary alloc] init];
            [item setObject:marker.title forKey:@"title"];
            [item setObject:self.currentLocation forKey:@"saddr"];
            CLLocation *daddr = [[CLLocation alloc] initWithLatitude:marker.position.latitude longitude:marker.position.longitude];
            [item setObject:daddr forKey:@"daddr"];
            [sideItems addObject:item];
        }
        
        JASidePanelController *sideVc = [self sidePanelController];
        SideListViewController *listVc = (SideListViewController*)sideVc.rightPanel;
        [listVc updateItems:sideItems];
        
        [self moveToCurrentLocation];
    });
}

- (void)moveToCurrentLocation
{
    GMSCameraPosition *cameraPos = [GMSCameraPosition cameraWithLatitude:self.currentLocation.coordinate.latitude
                                                               longitude:self.currentLocation.coordinate.longitude
                                                                    zoom:15 bearing:0
                                                            viewingAngle:60];
    [self.mapView setCamera:cameraPos];
}

- (NSMutableArray*)craeteMarkersFromLibraris:(NSArray*)records
{
    NSMutableArray *results = [[NSMutableArray alloc] init];
    if (records == nil) return results;
    
    for (NSDictionary *record in records) {
        
        NSString *tel;
        NSNumber *distance;
        NSString *address;
        NSString *formal;
        NSString *geocode;
        
        if (record[@"tel"] != [NSNull null]) {
            tel = record[@"tel"];
        }
        else {
            tel = @"";
        }
        
        if (record[@"distance"] != [NSNull null]) {
            distance = record[@"distance"];
        }
        else {
            distance = nil;
        }
        
        if (record[@"address"] != [NSNull null]) {
            address = record[@"address"];
        }
        else {
            address = @"";
        }
        
        if (record[@"formal"] != [NSNull null]) {
            formal = record[@"formal"];
        }
        else {
            formal = @"";
        }
        
        if (record[@"geocode"] != [NSNull null]) {
            geocode = record[@"geocode"];
        }
        else {
            geocode = nil;
        }
        
        if (geocode == nil) continue;
        
        NSArray *lnglat = [geocode componentsSeparatedByString:@","];
        NSString *lngStr = lnglat[0];
        NSString *latStr = lnglat[1];
        double lng = [lngStr doubleValue];
        double lat = [latStr doubleValue];
        
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.position = CLLocationCoordinate2DMake(lat, lng);
        marker.title = [[NSString alloc] initWithFormat:@"%@", formal];
        marker.snippet = [[NSString alloc] initWithFormat:@"%@ ここから%dm", address, (int)round([distance doubleValue] * 1000)];
        marker.appearAnimation = kGMSMarkerAnimationPop;
        marker.icon = [UIImage imageNamed:@"pin_library"];
        [results addObject:marker];
        
    }
    
    return results;
}

- (NSMutableArray*)craeteMarkersFromCafes:(NSArray*)records
{
    NSMutableArray *results = [[NSMutableArray alloc] init];
    if (records == nil) return results;
    
    for (NSDictionary *record in records) {
        
        NSString *address;
        NSString *name;
        NSString *wifi;
        NSString *lat;
        NSString *lng;
        
        if (record[@"address"] != [NSNull null]) {
            address = record[@"address"];
        }
        else {
            address = @"";
        }
        
        if (record[@"name"] != [NSNull null]) {
            name = record[@"name"];
        }
        else {
            name = @"";
        }
        
        if (record[@"wifi"] != [NSNull null]) {
            wifi = record[@"wifi"];
        }
        else {
            wifi = @"";
        }
        
        if (record[@"lat"] != [NSNull null]) {
            lat = record[@"lat"];
        }
        else {
            lat = @"";
        }
        
        if (record[@"lng"] != [NSNull null]) {
            lng = record[@"lng"];
        }
        else {
            lng = @"";
        }
        
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.position = CLLocationCoordinate2DMake([lat doubleValue], [lng doubleValue]);
        marker.title = [[NSString alloc] initWithFormat:@"%@ wifi%@", name, wifi];
        marker.snippet = [[NSString alloc] initWithFormat:@"%@", address];
        marker.appearAnimation = kGMSMarkerAnimationPop;
        marker.icon = [UIImage imageNamed:@"pin_cafe"];
        [results addObject:marker];
    }
    
    return results;
}

- (NSMutableArray*)craeteMarkersFromBookurus:(NSArray*)records
{
    NSMutableArray *results = [[NSMutableArray alloc] init];
    if (records == nil) return results;
    
    for (NSDictionary *record in records) {
        
        NSString *address;
        NSString *name;
        NSString *title;
        double lat;
        double lng;
        
        if (record[@"address__c"] != [NSNull null]) {
            address = record[@"address__c"];
        }
        else {
            address = @"";
        }
        
        if (record[@"Name"] != [NSNull null]) {
            name = record[@"Name"];
        }
        else {
            name = @"";
        }
        
        if (record[@"Title__c"] != [NSNull null]) {
            title = record[@"Title__c"];
        }
        else {
            title = @"";
        }
        
        if (record[@"LatLng__Latitude__s"] != [NSNull null]) {
            lat = [record[@"LatLng__Latitude__s"] doubleValue];
        }
        else {
            lat = 0;
        }
        
        if (record[@"LatLng__Longitude__s"] != [NSNull null]) {
            lng = [record[@"LatLng__Longitude__s"] doubleValue];
        }
        else {
            lng = 0;
        }
        
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.position = CLLocationCoordinate2DMake(lat, lng);
        marker.title = [[NSString alloc] initWithFormat:@"%@", title];
        marker.snippet = [[NSString alloc] initWithFormat:@"%@", address];
        marker.appearAnimation = kGMSMarkerAnimationPop;
        marker.icon = [UIImage imageNamed:@"pin_bookuru"];
        [results addObject:marker];
    }
    
    return results;
}

- (void)searchLibrary
{
    NSLog(@"Search Library");
    
    if (self.currentLocation == nil) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"位置情報を取得できないため実行できません。" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
        return;
    }
    
    NSDictionary *params = @{ @"appkey": @"9f02986935cf4e9f21013c0592359f76", @"geocode": [[NSString alloc] initWithFormat:@"%f,%f", self.currentLocation.coordinate.longitude, self.currentLocation.coordinate.latitude], @"format": @"json", @"callback": @""};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager GET:@"http://api.calil.jp/library"
      parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.indicator stopAnimating];
        });
        _mpMode = kMpLibrary;
        self.libraries = responseObject;
        [self setPinsOnMap];
    }
         failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.indicator stopAnimating];
        });
        NSLog(@"ERROR -> %@", error.localizedDescription);
    }];
    
    [self.indicator startAnimating];
}

- (void)searchCafe
{
    NSLog(@"Search Cafe");
    
    if (self.currentLocation == nil) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"位置情報を取得できないため実行できません。" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
        return;
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *range;
    switch ([defaults integerForKey:@"search_range"]) {
        case 300:
        {
            range = @"1";
            break;
        }
        case 500:
        {
            range = @"2";
            break;
        }
        case 1000:
        {
            range = @"3";
            break;
        }
        case 2000:
        {
            range = @"4";
            break;
        }
        case 5000:
        {
            range = @"5";
            break;
        }
        default:
        {
            range = @"5";
            break;
        }
    }
    
    NSString *wifi;
    if ([defaults boolForKey:@"search_with_wifi"] == YES) {
        wifi = @"1";
    }
    else {
        wifi = @"0";
    }
    
    NSDictionary *params = @{ @"key": @"6af0e93d71b96b40", @"genre": @"G014", @"lat": [[NSString alloc] initWithFormat:@"%f", self.currentLocation.coordinate.latitude], @"lng": [[NSString alloc] initWithFormat:@"%f", self.currentLocation.coordinate.longitude], @"range": range, @"wifi": wifi, @"order": @"1", @"count": @"100", @"format": @"json"};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager GET:@"http://webservice.recruit.co.jp/hotpepper/gourmet/v1/"
      parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         dispatch_async(dispatch_get_main_queue(), ^{
             [self.indicator stopAnimating];
         });
         _mpMode = kMpCafe;
         NSDictionary *results = responseObject[@"results"];
         self.cafes = results[@"shop"];
         [self setPinsOnMap];
     }
         failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         dispatch_async(dispatch_get_main_queue(), ^{
             [self.indicator stopAnimating];
         });
         NSLog(@"ERROR -> %@", error.localizedDescription);
     }];
    
    [self.indicator startAnimating];
}

- (void)searchBookuru
{
    NSLog(@"Search Bookuru");
    
    if (self.currentLocation == nil) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"位置情報を取得できないため実行できません。" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
        return;
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    double range;
    if ([defaults integerForKey:@"search_range"] == 0) {
        range = 5;
    }
    else {
        range = [defaults integerForKey:@"search_range"] / 1000;
    }
    
    
    NSString *query = [[NSString alloc] initWithFormat:@"SELECT Id, Name, address__c, LatLng__Latitude__s, LatLng__Longitude__s, LatLng__c, Note__c, Title__c FROM Bookuru__c WHERE DISTANCE(LatLng__c, GEOLOCATION(%f,%f), 'km') < %f", self.currentLocation.coordinate.latitude, self.currentLocation.coordinate.longitude, range];
    SFRestAPI *api = [SFRestAPI sharedInstance];
    SFRestRequest *request = [api requestForQuery:query];
    [api sendRESTRequest:request
               failBlock:^(NSError *error)
    {
        NSLog(@"ERROR -> %@", error.localizedDescription);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.indicator stopAnimating];
        });
    }
           completeBlock:^(id jsonResponse)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.indicator stopAnimating];
        });
        _mpMode = kMpBookuru;
        self.bookurus = jsonResponse[@"records"];
        [self setPinsOnMap];
    }];
    
    [self.indicator startAnimating];
}

- (void)refresh
{
    [self.mapView removeFromSuperview];
    [self.mapContainerView addSubview:self.mapView];
}

#pragma mark - Events
- (IBAction)askBookuru:(id)sender {
    
    AHKActionSheet *actionSheet = [[AHKActionSheet alloc] initWithTitle:NSLocalizedString(@"現在位置をお気に入りの勉強場所として登録しますか？", nil)];
    
    [actionSheet addButtonWithTitle:NSLocalizedString(@"はい", nil)
                              image:[UIImage imageNamed:@"icon_yes"]
                               type:AHKActionSheetButtonTypeDefault
                            handler:^(AHKActionSheet *as) {
                                BookuruViewController *next = (BookuruViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"bookuru"];
                                next.currentAddress = self.currentAddress;
                                next.location = self.currentLocation;
                                [self presentViewController:next animated:YES completion:nil];
                            }];
    
    [actionSheet show];
    
}

@end
