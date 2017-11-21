//
//  ViewController.m
//  HelloMap
//
//  Created by Kent Liu on 2014/12/26.
//  Copyright (c) 2014年 Kent Liu. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MyImageAnnotationView.h"

@interface ViewController () <MKMapViewDelegate,CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
    BOOL firstLocationReceived;
}
@property (weak, nonatomic) IBOutlet MKMapView *theMapView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // Ask Location Permission
    
    locationManager=[CLLocationManager new];
    
    if([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])
    {
        [locationManager requestWhenInUseAuthorization];
    }
    
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.activityType = CLActivityTypeAutomotiveNavigation;
    locationManager.delegate = self;
    [locationManager startUpdatingLocation];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)mapTypeChanged:(id)sender {
    
    NSInteger targetIndex = [sender selectedSegmentIndex];
    
    switch (targetIndex) {
        case 0:
            _theMapView.mapType=MKMapTypeStandard;
            break;
        case 1:
            _theMapView.mapType=MKMapTypeSatellite;
            break;
        case 2:
            _theMapView.mapType=MKMapTypeHybrid;
            break;
            
        default:
            break;
    }
}
- (IBAction)trackingModeChanged:(id)sender {
    
    NSInteger targetIndex = [sender selectedSegmentIndex];
    
    switch (targetIndex) {
        case 0:
            _theMapView.userTrackingMode=MKUserTrackingModeNone;
            break;
        case 1:
            _theMapView.userTrackingMode=MKUserTrackingModeFollow;
            break;
        case 2:
            _theMapView.userTrackingMode=MKUserTrackingModeFollowWithHeading;
            break;
            
        default:
            break;
    }
    
}

- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    CLLocation *newLocation = locations.lastObject;
    
    NSLog(@"Current Location: %.6f,%.6f",newLocation.coordinate.latitude,newLocation.coordinate.longitude);

    if(firstLocationReceived == NO)
    {
        MKCoordinateRegion region = _theMapView.region;
        region.center = newLocation.coordinate;
        region.span.latitudeDelta=0.01;
        region.span.longitudeDelta=0.01;
        [_theMapView setRegion:region animated:YES];
        firstLocationReceived = YES;
        
        // Add Annotation
        CLLocationCoordinate2D annoationCoordinate = newLocation.coordinate;
        annoationCoordinate.latitude += 0.0005;
        annoationCoordinate.longitude += 0.0005;
        
        MKPointAnnotation *annotation = [MKPointAnnotation new];
        annotation.coordinate=annoationCoordinate;
        annotation.title=@"肯德基";
        annotation.subtitle=@"真好吃🍗";
        
        [_theMapView addAnnotation:annotation];
    }
}

- (MKAnnotationView*) mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    if(annotation == mapView.userLocation)
        return nil;
    
//    MKPinAnnotationView *resultView = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"Store"];
    MyImageAnnotationView *resultView = (MyImageAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"Store"];
    
    if(resultView==nil)
    {
//        resultView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"Store"];
        resultView = [[MyImageAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"Store"];
    }
    else
    {
        resultView.annotation = annotation;
    }
    
    resultView.canShowCallout = YES;
    
    UIButton *rightButton=[UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    
    [rightButton addTarget:self action:@selector(buttonPrssed:) forControlEvents:UIControlEventTouchUpInside];
    
    resultView.rightCalloutAccessoryView=rightButton;
    
//    resultView.animatesDrop = YES;
//    resultView.pinColor=MKPinAnnotationColorGreen;
    
    
    return resultView;
}

- (void) buttonPrssed:(id)sender {
    
    UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:nil message:@"Button Pressed." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
    
}





@end





